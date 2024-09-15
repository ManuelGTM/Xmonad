-- Xmonad

import XMonad
import XMonad.ManageHook
import System.Exit
import System.IO(hClose,hPutStr,hPutStrLn)

-- Actions --
 
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.Plane
import XMonad.Actions.Minimize
import XMonad.Actions.SpawnOn

-- Utilities --

import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
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
import XMonad.Hooks.ShowWName
import XMonad.Hooks.WindowSwallowing

-- Layouts --

import XMonad.Layout.Spacing
import XMonad.Layout.ShowWName
import XMonad.Layout.Minimize
import qualified XMonad.Layout.BoringWindows as BW 
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.Fullscreen (fullscreenFull, fullscreenSupport)
import XMonad.Layout.Grid (Grid(..))
import XMonad.Layout.TwoPane (TwoPane(..))
import XMonad.Layout.Tabbed (simpleTabbed)

-- Data --

import qualified Data.Map as M
import Data.Monoid
import qualified XMonad.StackSet as W
import Data.Char (isSpace, toUpper)

------------------------------------------------------------------------------
-- Config file --
--------------------------------------------------------

-- My Terminal --
myTerminal      = "kitty"
rofi = "~/.config/rofi/launchers/type-7/launcher.sh"

-- multimedia assets
volmute    = "~/.config/xmonad/dunstvol mute"
volup      = "~/.config/xmonad/dunstvol up"
voldown    = "~/.config/xmonad/dunstvol down"
recordrofi = "~/.config/xmonad/recordrofi"


-- sound function
-- sounds :: String -> String
-- sounds (x) = "mpv --no-video ~/.config/sounds/" x

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
myNormalBorderColor  = "#6c7086"
myFocusedBorderColor = "#cba6f7"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- My Workspaces --
------------------------------------------------------------------------

myWorkspaces :: [String]
-- myWorkspaces = [" \xf0ca0" ," \xf0ca2", " \xf0ca4", " \xf0ca6", " \xf0ca8", " \xf0caa", " \xf0cac", " \xf0cae", " \xf0cb0 "]
myWorkspaces = [" dev ", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

------------------------------------------------------------------------
-- Named Actions --
------------------------------------------------------------------------
subtitle' ::  String -> ((KeyMask, KeySym), NamedAction)
subtitle' x = ((0,0), NamedAction $ map toUpper
                      $ sep ++ "\n-- " ++ x ++ " --\n" ++ sep)
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
  h <- spawnPipe $ "yad --text-info --fontname=\"Mononoki Nerd Font 12\" --fore=#46d9ff back=#282c36 --center --geometry=1200x800 --title \"XMonad keybindings\""

  hPutStr h (unlines $ showKmSimple x) -- showKmSimple doesn't add ">>" to subtitles
  hClose h
  return ()

------------------------------------------------------------------------
-- Key bindings --
myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]

myKeys c =  
  let subKeys str ks = subtitle' str : mkNamedKeymap c ks in
  subKeys "Xmonad Essentials" 

 -- Window navigation keybindings
    [ ("M-s", addName "Move focus to the next window" $ windows W.focusDown >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")
    , ("M-n", addName "Move focus to the previous window" $ windows W.focusUp >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")
    , ("M-g", addName "Move focus to the master window" $ windows W.focusMaster)
    , ("M-<Return>", addName "Swap the focused window with the master window" $ windows W.swapMaster)
    , ("M-S-s", addName "Swap the focused window with the next window" $ windows W.swapDown >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")
    , ("M-S-n", addName "Swap the focused window with the previous window" $ windows W.swapUp >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")
    
    -- Window resizing keybindings
    , ("M-k", addName "Shrink the master area" $ sendMessage Shrink >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")
    , ("M-p", addName "Expand the master area" $ sendMessage Expand >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")
    , ("M-w", addName "Push window back into tiling" $ withFocused $ windows . W.sink)
    , ("M-y", addName "Increase the number of windows in the master area" $ sendMessage (IncMasterN 1))
    , ("M-S-y", addName "Decrease the number of windows in the master area" $ sendMessage (IncMasterN (-1)))

    -- Terminal and application keybindings
    , ("M-t", addName "Launch terminal" $ spawn "mpv --no-video ~/.config/sounds/M_UI_00000040.flac" >> spawn myTerminal)
    , ("M-v", addName "Launch browser" $ spawn "firefox" >> spawn "mpv --no-video ~/.config/sounds/M_UI_0000001B.flac")
    , ("M-S-i", addName "Launch Postman" $ spawn (myTerminal ++ " -e postman") >> spawn "mpv --no-video ~/.config/sounds/M_UI_0000001B.flac")
    , ("M-S-p", addName "Take screenshot" $ spawn (myTerminal ++ " -e scrot ~/ScreenShots/") >> spawn "mpv --no-video ~/.config/sounds/M_UI_0000001B.flac")
    , ("M-<Space>", addName "Launch Rofi" $ spawn rofi >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000038.flac")

    -- Scratchpads keybindings
    , ("M-S-t", addName "Launch terminal scratchpad" $ spawnScratch "terminal")
    , ("M-o", addName "Launch Spotify" $ spawnScratch "spotify")
    , ("M-S-o", addName "Launch htop" $ spawnScratch "htop")


    -- Eww Widgets
    , ("M-S-d", addName "Toggle calendar" $ spawn "eww open --toggle date")
    , ("M-S-b", addName "Toggle launchermenu" $ spawn "eww open --toggle launchermenu")
    , ("M-S-u", addName "show conky" $ spawn "pgrep conky && pkill conky") 
    , ("M-u", addName "show conky" $ spawnScratch "conky")


    -- Multimedia keybindings
    , ("M-S-l", addName "Toggle mute" $ spawn volmute)
    , ("M-l", addName "Lower volume" $ spawn voldown)
    , ("M-d", addName "Raise volume" $ spawn volup)


    -- Window management keybindings
    , ("M-q", addName "Kill focused window" $ spawn "mpv --no-video ~/.config/sounds/M_UI_0000000E.flac" >> kill)
    , ("M-r", addName "Rotate through layouts" $ sendMessage NextLayout >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000039.flac")
    , ("M-m", addName "Minimize window" $ withFocused minimizeWindow >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac")
    , ("M-S-m", addName "Maximize window" $ withLastMinimized maximizeWindow >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000018.flac")
    , ("M-z", addName "Toggle struts" $ sendMessage ToggleStruts)

    -- XMonad control keybindings
    , ("M-S-q", addName "Quit XMonad" $ io (exitWith ExitSuccess))
    , ("M-f", addName "Recompile and restart XMonad" $ spawn "xmonad --recompile;xmonad --restart" >> spawn "mpv --no-video ~/.config/sounds/M_UI_00000025.flac")]   

    -- Workspace keybindings
      
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
  { swn_font = "xft:Ubuntu Bold:size=80"
    , swn_fade = 0.5
    , swn_bgcolor = "#1E1E2E"  -- Ajusta el color de fondo
    , swn_color = "#d8dee9"    -- Ajusta el color del texto
    }

--------------------------------------------------------------------------------------
-- My layouts --

myLayout = spacingWithEdge 6 $ avoidStruts $ 

    tiled ||| Mirror tiled ||| Full ||| Grid  

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
    [ className =? "error"        --> doFloat
    , className =? "spotify"        --> doShift ( myWorkspaces !! 4)
    , className =? "DesktopEditors"        --> doShift ( myWorkspaces !! 3)
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    ] <+> namedScratchpadManageHook myScratchPads

--------------------------------------------------------------------------------------
--  Scratchpads --

spawnScratch = namedScratchpadAction myScratchPads -- easier to write 

myScratchPads :: [NamedScratchpad]
myScratchPads = [
    NS "terminal" spawnTerm findTerm manageTerm
    ,NS "spotify" spawnSpotify findSpotify manageSpotify
    ,NS "htop" spawnHtop findHtop manageHtop
    , NS "conky" spawnConky findConky manageConky 
  ]
  where
    -- Terminal Scratchpad 
    spawnTerm  = myTerminal ++ " --class scratchpad "
    findTerm   = className =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.8
                 w = 0.8
                 t = (1 - h) / 2
                 l = (1 - w) / 2 

    -- Spotiy Scratchpad
    spawnSpotify  = "spotify"
    findSpotify   = className =? "Spotify"
    manageSpotify = customFloating $ W.RationalRect l t w h
      where
        h = 0.8  -- altura del scratchpad
        w = 0.8  -- ancho del scratchpad
        t = (1 - h) / 2  -- top (centrado verticalmente)
        l = (1 - w) / 2  -- left (centrado horizontalmente)

    -- Htop Scratchpad
    spawnHtop  = myTerminal ++ " --class htop -e htop"
    findHtop   = className =? "htop"
    manageHtop = customFloating $ W.RationalRect l t w h
      where
        h = 0.6  -- altura del scratchpad
        w = 0.6  -- ancho del scratchpad
        t = (1 - h) / 2  -- top (centrado verticalmente)
        l = (1 - w) / 2  -- left (centrado horizontalmente)

    -- Conky Scratchpad
    spawnConky  = "conky -c ~/.config/conky/conky.conf" -- Ruta de tu configuración de conky
    findConky   = className =? "Conky"                     -- Encuentra la ventana de Conky
    manageConky = customFloating $ W.RationalRect l t w h  -- Posición y tamaño de Conky
                   where
                     h = 0.4     -- Altura: 40% de la pantalla
                     w = 0.2     -- Ancho: 20% de la pantalla
                     t = 0.1     -- Distancia desde arriba: 10%
                     l = 0.7     -- Distancia desde la izquierda: 70%

--------------------------------------------------------------------------------------
-- Event Handling --

--myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

myLogHook = return ()

--------------------------------------------------------------------------------------
-- Starup hook --

myStartupHook :: X ()
myStartupHook = do
        spawnOnce "killall conky"
        spawnOnce "pamixer --set-volume 60 &"
        spawnOnce "mpv --no-video ~/.config/sounds/BOTW_Startup.wav &"
        spawnOnce "nitrogen --restore &" 
        spawnOnce "picom --config ~/.config/picom/picom.conf &"
        spawnOnce "dunst &"
        spawnOnce "eww daemon &"
       
main :: IO ()
main = do
    xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/.xmobarrc" -- xmobar hook  

    xmonad $ addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $ 
             docks 
             . ewmh 
             . ewmhFullscreen $ 
             def
        { manageHook = ( isFullscreen --> doFullFloat ) <+> myManageHook <+> manageDocks
        , handleEventHook    = serverModeEventHookCmd
                               <+> serverModeEventHook
                              <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn)
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = minimize . BW.boringWindows $ showWName' myShowWNameTheme $ myLayout                                        
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor                                                         
        , focusedBorderColor = myFocusedBorderColor
        , logHook = workspaceHistoryHook <+> myLogHook <+> dynamicLogWithPP xmobarPP
                      { ppOutput = \x -> hPutStrLn xmproc x
                        ,ppCurrent = xmobarColor "#fab387" "" . wrap "["  "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#ffbf00" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#cba6f7" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#a6adc8" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#89b4fa" "" . shorten 74     -- Title of active window in xmobar
                        , ppSep =  "<fc=#7393b3>  | </fc> "                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]   
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        } 
 
