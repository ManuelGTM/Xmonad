import XMonad
import XMonad.ManageHook
import System.Exit
import System.IO(hClose,hPutStr,hPutStrLn)

-- Actions --
 
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.Plane
import XMonad.Actions.Minimize

-- Utilities --

import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.NamedActions
import Graphics.X11.ExtraTypes.XF86

-- Hooks --

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.RefocusLast
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName

-- Layouts --

import XMonad.Layout.Spacing
import XMonad.Layout.ShowWName
import XMonad.Layout.Minimize
import qualified XMonad.Layout.BoringWindows as BW 

-- Data --
import qualified Data.Map as M
import Data.Monoid
import qualified XMonad.StackSet as W
import Data.Char (isSpace, toUpper)
------------------------------------------------------------------------------

-- Config file --

--------------------------------------------------------

-- My Terminal --
myTerminal      = "alacritty"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myBorderWidth   = 2 -- Width of the window border in pixels.
  
myModMask       = mod4Mask

myBrowser = "firefox" -- my current browser

myeditor = "nvim" -- my editor

-- Border colors for unfocused and focused windows, respectively.
-- myNormalBorderColor  = "#a153e1"
myNormalBorderColor  = "#C21e56"
myFocusedBorderColor = "#cd7f32"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- My Workspaces --

myWorkspaces :: [String]
myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

------------------------------------------------------------------------
-- Named Actions --

subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                      $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"SauceCodePro Nerd Font Mono 12\" --fore=#46d9ff back=#282c36 --center --geometry=1200x800 --title \"XMonad keybindings\""

  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

------------------------------------------------------------------------
-- Key bindings --
myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]

myKeys c =  
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
  subKeys "Xmonad Essentials" 

    -- Windows navigation
    [("M-s",         addName "Move focus to next window"                              $ windows W.focusDown>> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")              -- Move focus to the next window
    , ("M-n",        addName "Move focus to previous window"                          $ windows W.focusUp>> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")                 -- Move focus to the previous window
    , ("M-g",        addName "Move focus to master"                                   $ windows W.focusMaster)              -- Move focus to the master window
    , ("M-<Return>", addName "Swap the focus window and the master window"            $ windows W.swapMaster)               -- Swap the focused window and the master window
    , ("M-S-s",      addName "Swap the focused window with the next window"           $ windows W.swapDown >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")                 --  Swap the focused window with the next window
    , ("M-S-n",      addName "Swap the focused window with the previous window"       $ windows W.swapUp >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")                   -- Swap the focused window with the previous window
    , ("M-k",        addName "Shrink the master area"                                 $ sendMessage Shrink >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")                 -- Shrink the master area
    , ("M-h",        addName "Expand the master area"                                 $ sendMessage Expand >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")                 -- Shrink the master area                 -- Expand the master area
    , ("M-w",        addName "Push window back into tiling"                           $ withFocused $ windows . W.sink)     -- Push window back into tiling
    , ("M-<Comma>",  addName "Increment the number of windows in the master area"     $ sendMessage (IncMasterN 1))         -- Increment the number of windows in the master area
    , ("M-<Period>", addName "Deincrement the number of windows in the master area"   $ sendMessage (IncMasterN (-1)))      -- Deincrement the number of windows in the master area

     -- Terminal keybindings 
    ,("M-t",  addName "launch the terminal"   $ spawn "mpv --no-video ~/.config/sounds/M_UI_00000040.flac" >> spawn myTerminal)  -- launch a terminal

     -- Applications Keybindings
    ,("M-b",  addName "launch browser"  $ spawn "firefox" >> spawn "mpv --no-video ~/.config/sounds/M_UI_0000001B.flac")           -- launch browser
    ,("M-o",  addName "launch browser"  $ spawn "spotify-launcher")           -- launch spotify-launcher
    ,("M-p",  addName "launch rofi"     $ spawn "rofi -show run" >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")     -- launch rofi
    ,("M-d",  addName "launch emacs"    $ spawn "emacs")             --launch emacs

      --Multimedia keybindings
    , ("M-l",    addName "Mute the audio"    $ spawn "pamixer --mute")
    , ("M-S-l",  addName "Unmute the audio"  $ spawn "pamixer --unmute")  -- unmute volume
    , ("M-S-u",  addName "Low the volume"    $ spawn "pamixer --decrease 5" >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")  -- Lower volume 
    , ("M-u",    addName "Raise the volume"  $ spawn "pamixer --increase 5">> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")   -- Raise volume 

      -- Windows keybindings
    ,("M-q",        addName "kill focused windows"                        $ spawn "mpv --no-video ~/.config/sounds/M_UI_0000000E.flac" >> kill)                                 -- kill focused windows
    ,("M-<Space>",  addName "Rotate through layouts"                      $ sendMessage NextLayout >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")               -- Rotate through layouts
    ,("M-y",        addName "Resize windows to correct size"              $ refresh)                              -- Resize windows to correct size
    ,("M-m",        addName "Minimize window"                             $ withFocused minimizeWindow >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac")       -- Minimize window
    , ("M-S-m",     addName "Maximize window"                             $ withLastMinimized maximizeWindow >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac")     -- Maximize window
    , ("M-z",       addName "Avoid Struts (helps with the bar overflow)"  $ sendMessage ToggleStruts)             -- avoid struts

    -- Xmonad keybindings

    , ("M-S-q",     addName "Quit Xmonad"                   $ io (exitWith ExitSuccess))                       -- Quit xmonad 
    , ("M-f",       addName "Restart and recompile Xmonad"  $ spawn "xmonad --recompile;xmonad --restart" >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000025.flac") ]   -- Restart xmonad
      
    ^++^ subKeys "Switch to workspace"
    [ ("M-1", addName "Switch to workspace 1"    $ (windows $ W.greedyView $ myWorkspaces !! 0) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac") 
    , ("M-2", addName "Switch to workspace 2"    $ (windows $ W.greedyView $ myWorkspaces !! 1) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-3", addName "Switch to workspace 3"    $ (windows $ W.greedyView $ myWorkspaces !! 2) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-4", addName "Switch to workspace 4"    $ (windows $ W.greedyView $ myWorkspaces !! 3) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-5", addName "Switch to workspace 5"    $ (windows $ W.greedyView $ myWorkspaces !! 4) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-6", addName "Switch to workspace 6"    $ (windows $ W.greedyView $ myWorkspaces !! 5) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-7", addName "Switch to workspace 7"    $ (windows $ W.greedyView $ myWorkspaces !! 6) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-8", addName "Switch to workspace 8"    $ (windows $ W.greedyView $ myWorkspaces !! 7) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")
    , ("M-9", addName "Switch to workspace 9"    $ (windows $ W.greedyView $ myWorkspaces !! 8) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000050.flac")]

    ^++^ subKeys "Send window to workspace"
    [ ("M-S-1", addName "Send to workspace 1"    $ (windows $ W.shift $ myWorkspaces !! 0) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-2", addName "Send to workspace 2"    $ (windows $ W.shift $ myWorkspaces !! 1) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-3", addName "Send to workspace 3"    $ (windows $ W.shift $ myWorkspaces !! 2) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-4", addName "Send to workspace 4"    $ (windows $ W.shift $ myWorkspaces !! 3) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-5", addName "Send to workspace 5"    $ (windows $ W.shift $ myWorkspaces !! 4) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-6", addName "Send to workspace 6"    $ (windows $ W.shift $ myWorkspaces !! 5) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-7", addName "Send to workspace 7"    $ (windows $ W.shift $ myWorkspaces !! 6) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-8", addName "Send to workspace 8"    $ (windows $ W.shift $ myWorkspaces !! 7) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac") 
    , ("M-S-9", addName "Send to workspace 9"    $ (windows $ W.shift $ myWorkspaces !! 8) >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac")]
   
      
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events     
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
---------------------------------------------------------------------------------------

-- Themes for showWname wich prints current workspace when you chnaeg workspaces --


myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Sans:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#000000"
    , swn_color             = "#FFFFFF"
    }
--------------------------------------------------------------------------------------
-- My layouts --

myLayout = spacingWithEdge 6 $ avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

--------------------------------------------------------------------------------------
-- Window Rules --

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

--------------------------------------------------------------------------------------
-- Event Handling --

--myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

myLogHook = return ()

--------------------------------------------------------------------------------------
-- Starup hook --

myStartupHook = do
        spawnOnce "pamixer --set-volume 60 &"
        spawnOnce "mpv --no-video ~/.config/sounds/BOTW_Startup.wav &"
        spawnOnce "nitrogen --restore &" 
        spawnOnce "picom &"

main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/.xmobarrc" -- xmobar hook  

    xmonad $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $ docks . ewmh $ def
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks
        , handleEventHook    = serverModeEventHookCmd
                               <+> serverModeEventHook
                              <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = minimize . BW.boringWindows $ showWName' myShowWNameTheme myLayout                                        
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor                                                         
        , focusedBorderColor = myFocusedBorderColor
        , logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x
                        ,ppCurrent = xmobarColor "#cd7f32" "" . wrap "["  "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#ffbf00" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#eedc82" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#f0ffff" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#7393b3>  || </fc> "                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]   
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        } 
 
