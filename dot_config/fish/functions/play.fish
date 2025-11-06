function play
    # Check if gum is installed
    if not command -v gum &> /dev/null
        echo "Error: gum is not installed. Install it from: https://github.com/charmbracelet/gum"
        return 1
    end
    # Check if PLAYGROUND_DIR is set
    if not set -q PLAYGROUND_DIR
        echo "Error: PLAYGROUND_DIR environment variable is not set"
        echo "Set it in your fish config: set -Ux PLAYGROUND_DIR /path/to/playground"
        return 1
    end
    # Ask for project type/category
    set category (gum choose "python" "rust" "golang" "nodejs" "other")
    
    # Check if user cancelled
    if test -z "$category"
        echo "Cancelled: No category selected"
        return 1
    end
    
    # If "other" was selected, ask for custom category
    if test "$category" = "other"
        set category (gum input --placeholder "Enter category name (e.g., java, cpp, ruby)")
        
        if test -z "$category"
            echo "Cancelled: No category provided"
            return 1
        end
    end
    
    # Ask for project name
    set name (gum input --placeholder "What's the project name?")
    
    # Check if user cancelled or provided empty input
    if test -z "$name"
        echo "Cancelled: No project name provided"
        return 1
    end
    # Create the directory path
    set project_path "$PLAYGROUND_DIR/$category/$name"
    
    # Check if directory already exists
    if test -d "$project_path"
        gum style --foreground 214 --border double --padding "1 2" \
            "⚠ Project already exists!" \
            "" \
            "Location: $project_path"
        
        # Ask if user wants to open existing project
        if gum confirm "Open existing project in VS Code?"
            cd "$project_path"
            if command -v code &> /dev/null
                code .
            else
                echo "Error: VS Code 'code' command not found"
                echo "Make sure VS Code is installed and the 'code' command is in your PATH"
            end
        else
            # Just cd to the directory if they don't want to open VS Code
            cd "$project_path"
        end
        return 0
    end
    
    # Create the directory
    mkdir -p "$project_path"
    
    # Check if directory was created successfully
    if test $status -eq 0
        gum style --foreground 212 --border double --padding "1 2" \
            "✓ Project created successfully!" \
            "" \
            "Location: $project_path"
        
        # Change to the new directory
        cd "$project_path"
        
        # Ask if user wants to open in VS Code
        if gum confirm "Open in VS Code?"
            if command -v code &> /dev/null
                code .
            else
                echo "Error: VS Code 'code' command not found"
                echo "Make sure VS Code is installed and the 'code' command is in your PATH"
            end
        end
    else
        echo "Error: Failed to create directory at $project_path"
        return 1
    end
end