if status is-interactive
   
    # Commands to run in interactive sessions can go here
    set fish_greeting
    
    # Sashimi prompt
    function fish_prompt
      set -l last_status $status
      set -l cyan (set_color -o 7DF9FF)
      set -l yellow (set_color -o e0af68)
      set -l Orange (set_color -o ff9e64)
      set -g red (set_color -o f7768e)
      set -g blue (set_color -o 008080)
      set -l green (set_color -o 9ece6a)
      set -l purple (set_color -o 9d7cd8)
      set -g normal (set_color -o C0C0C0) 

      set -l ahead (_git_ahead)
      set -g whitespace ' '

      if test $last_status = 0
        set initial_indicator "$green◆"
        set status_indicator "$normal❯$cyan❯$yellow❯"
      else
        set initial_indicator "$red✖ $last_status"
        set status_indicator "$red❯$red❯$red❯"
      end
      set -l cwd $Orange(basename (prompt_pwd))

      if [ (_git_branch_name) ]

        if test (_git_branch_name) = 'master'
          set -l git_branch (_git_branch_name)
          set git_info "$normal git:($red$git_branch$normal)"
        else
          set -l git_branch (_git_branch_name)
          set git_info "$normal git:($blue$git_branch$normal)"
        end

        if [ (_is_git_dirty) ]
          set -l dirty "$yellow ✗"
          set git_info "$git_info$dirty"
        end
      end

      # Notify if a command took more than 5 minutes
      if [ "$CMD_DURATION" -gt 300000 ]
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
    
    #function to set vim keybindings
    function fish_user_key_bindings
        fish_vi_key_bindings
    end
    #end vim keybindings
    
   # TokyoNight Color Palette
    set -l foreground c0caf5
    set -l selection 283457
    set -l comment 565f89
    set -l red f7768e
    set -l orange ff9e64
    set -l yellow e0af68
    set -l green 9ece6a
    set -l purple 9d7cd8
    set -l cyan 7dcfff
    set -l pink bb9af7

    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
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

    #

    # Activates Neofetch
    neofetch
end
