if status is-interactive
   
    #--------------------------------------------------------
    # Commands to run in interactive sessions can go here
    #--------------------------------------------------------

    set fish_greeting

    
    #--------------------------------------------------------
    # Themes and fonts colors
    #--------------------------------------------------------

   # TokyoNight Color Palette
    set -l foreground cdd6f4
    set -l selection f5e0dc
    set -l comment 565f89
    set -l red f38ba8
    set -l orange fab387
    set -l yellow f9e2af
    set -l green a6e3a1
    set -l purple b4befe
    set -l cyan 94e2d5
    set -l pink bb9af7


    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $orange
    set -g fish_color_redirection $green
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $green
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $purple
    set -g fish_color_valid_path $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment
    set -g fish_color_cancel $yellow

    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment
    set -g fish_pager_color_selected_background --background=$selection

    #--------------------------------------------------------
    # Shasimi prompt integration
    #--------------------------------------------------------

    # Sashimi prompt
    function fish_prompt
      set -l last_status $status
      set -l cyan (set_color -o 94e2d5)
      set -l yellow (set_color -o e0af68)
      set -l Orange (set_color -o fab387)
      set -g red (set_color -o f38ba8)
      set -g Bred (set_color -o f77a93)
      set -g blue (set_color -o 89b4fa)
      set -l green (set_color -o a6e3a1)
      set -l purple (set_color -o 9d7cd8)
      set -l magenta (set_color -o f5c2e7)
      set -l white (set_color -o bac2de)
      set -l gray (set_color -o E5E4E2)
      set -g normal (set_color -o bac2de) 

      set -l ahead (_git_ahead)
      set -g whitespace ' '

      if test $last_status = 0 
        set initial_indicator "$green◆ $magenta "
        # set initial_indicator "$white診本改善忍躾 $magenta "
        # set initial_indicator "$green◆$magenta $blue 本"
        set status_indicator "$purple❯$Orange❯$cyan❯"
      else
        set initial_indicator "$red✖ $last_status"
        set status_indicator "$red❯$red❯$red❯"
      end
      set -l cwd $cyan(basename (prompt_pwd))

      if [ (_git_branch_name) ]

        if test (_git_branch_name) = 'master'
          set -l git_branch (_git_branch_name)
          set git_info "$green git:($red$git_branch$green)"
        else
          set -l git_branch (_git_branch_name)
          set git_info "$green git:($red$git_branch$green)"
        end

        if [ (_is_git_dirty) ]
          set -l dirty "$red ✗"
          set git_info "$git_info$dirty"
        end
      end

      # Notify if a command took more than 5 minutes
      if [ "$CMD_DURATION" -gt 30000 ]
        echo The last command took (math "$CMD_DURATION/1000") seconds.
      end

      echo -n -s $initial_indicator $whitespace $cwd $git_info $whitespace $ahead $status_indicator $whitespace
    end

    function _git_ahead
      set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
      if [ $status != 0 ]
        return
      end
      set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
      set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
      switch "$ahead $behind"
        case ''     # no upstream
        case '0 0'  # equal to upstream
          return
        case '* 0'  # ahead of upstream
          echo "$blue↑$normal_c$ahead$whitespace"
        case '0 *'  # behind upstream
          echo "$red↓$normal_c$behind$whitespace"
        case '*'    # diverged from upstream
          echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
      end
    end

    function _git_branch_name
      echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
    end

    function _is_git_dirty
      echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
    end
    
    #end prompt
   
    #--------------------------------------------------------
    # Vim Functionality 
    #--------------------------------------------------------

    #function to set vim keybindings
    function fish_user_key_bindings
        fish_vi_key_bindings
    end
    #end vim keybindings

 
    #--------------------------------------------------------
    # System abbreviations
    #--------------------------------------------------------

    abbr Si "sudo pamac install" # Install software
    abbr Sr "sudo pamac remove"   # Uninstall some software 
    abbr Su "sudo pamac upgrade"  # Upgrade the system
    abbr Sd "sudo shutdown now" # Shutdown now

    #--------------------------------------------------------
    # Useful command abbreviations
    #--------------------------------------------------------

    abbr tmn "tmux new -s"  # Create a new session tmux
    abbr tma "tmux attach -t" # Attach to a session tmux
    abbr gc "gcc .c -o .out" # Compile C language
    abbr ls "exa"
    abbr ll "exa -alh"
    abbr tree "exa --tree"
    abbr cd "z"
    abbr cat "bat"

    #--------------------------------------------------------
    #Application startup abbreviations
    #--------------------------------------------------------

    abbr music "z /run/media/manueltgtm/Music"
    abbr calendar "khal calendar"
    abbr office "onlyoffice"
    abbr postgres "sudo psql -U  -d  -h 127.0.0.1"

    #--------------------------------------------------------
    # Functionality Tweaks
    #--------------------------------------------------------

    # ~/.tmux/plugins
    fish_add_path $HOME/.tmux/plugins/t-smart-tmux-session-manager/bin
    
   # Activates Neofetch
    #neofetch

    #zoxide
    zoxide init fish | source
end
