-- Imports --

import XMonad
import XMonad.ManageHook
import System.Exit

-- Actions --
 
import XMonad.Actions.CycleWS (moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.Plane
import XMonad.Actions.Minimize

-- Utilities --

import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.ClickableWorkspaces
import.Graphics.X11.ExtraTypes.XF86

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
myNormalBorderColor  = "#a153e1"
myFocusedBorderColor = "#e93a3a"

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- My Workspaces --

-- myWorkspaces    = ["  󰲒  ","     ","    ","    ","  󰌠  ","   ","    ","   ","     "]


myWorkspaces :: [String]

myWorkspaces = ["dev", " www ", " sys ", " doc ", " vbox ", " chat ", " mus ", " vid ", " gfx "]

------------------------------------------------------------------------

-- Key bindings --

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $[

   -- Terminal keybindings 
     ("M-t", spawn $ XMonad.terminal conf)                    -- launch a terminal

   -- Applications Keybindings
    ,("M-p", spawn "rofi -show run")                          -- launch rofi
    --,("M-b", spawn "firefox")                                 -- launch browser
    ,("M-d", spawn "emacs")                                   --launch emacs

    --Multimedia keybindings
  , ("<XF86AudioMute>", spawn "pactl set-sink-mute 3 toggle")
  , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume 3 -10%")
  , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume 3 +10%")

    -- Windows keybindings
    ,("M-q", kill)                                            -- kill focused windows
    ,("M-<Space>", sendMessage NextLayout)                    -- Rotate through layouts
    ,("M-S-<Space>", setLayout $ XMonad.layoutHook conf)      -- Reset the layout to default
    ,("M-y", refresh)                                         -- Resize windows to correct size
    ,("M-m", withFocused minimizeWindow)                      -- Minimize window
    , ("M-S-m", withLastMinimized maximizeWindow)             -- Maximize window
    
    -- Windows navigation
    , ("M-s", windows W.focusDown)                            -- Move focus to the next window
    , ("M-n", windows W.focusUp)                              -- Move focus to the previous window
    , ("M-g", windows W.focusMaster)                          -- Move focus to the master window
    , ("M-<Return>", windows W.swapMaster)                    -- Swap the focused window and the master window
    , ("M-S-s", windows W.swapDown)                           -- Swap the focused window with the next window
    , ("M-S-n", windows W.swapUp)                             -- Swap the focused window with the previous window
    , ("M-k", sendMessage Shrink)                             -- Shrink the master area
    , ("M-h", sendMessage Expand)                             -- Expand the master area
    , ("M-w", withFocused $ windows . W.sink)                 -- Push window back into tiling
    , ("M-<Comma>", sendMessage (IncMasterN 1))               -- Increment the number of windows in the master area
    , ("M-<Period>", sendMessage (IncMasterN (-1)))           -- Deincrement the number of windows in the master area
    

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    
    , ("M-z", sendMessage ToggleStruts)

    -- Xmonad keybindings

    , ("M-S-q", io (exitWith ExitSuccess))                    -- Quit xmonad
    , ("M-f", spawn "xmonad --recompile; xmonad --restart")   -- Restart xmonad

    ]
    ++

    
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
     
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3

    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--  
-- Themes for showWname wich prints current workspace when you chnaeg workspaces

myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:Sans:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#000000"
    , swn_color             = "#FFFFFF"
    }


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

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]




------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        spawnOnce "mpv --no-video ~/.config/sounds/yoooo.mp3"
        spawnOnce "nitrogen --restore &"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
 

main = do
  xmproc <- spawnPipe "xmobar -x 0 ~/.config/xmobar/.xmobarrc" -- xmobar hook

  xmonad $ ewmh . docks $ defaults
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
                        ,ppCurrent = xmobarColor "#c3e88d" "" . wrap "[ "" ]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#c3s88d" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "*" ""   -- Hidden workspaces in xmobar
                        , ppHiddenNoWindows = xmobarColor "#F07178" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#d0d0d0" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> | </fc>"                     -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        , ppExtras  = [windowCount]   
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
        }    `addtionalKeysP` myKeys
 

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

 
