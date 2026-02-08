{ config, ... }:
let
  c = config.modules.colors;
in
{
  xdg.configFile."rofi/theme.rasi".text = ''
    * {
      background: ${c.base00};
      background-alt: ${c.base01};
      foreground: ${c.base06};
      selected: ${c.base0B};
      border: ${c.base06}1A;
      urgent: ${c.base0F};
    }

    /* Main Window */
    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       700px;
        x-offset:                    0px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border-radius:               10px;
        border-color:                @border;
        border:                      1px;
        cursor:                      "default";
        background-color:            @background;
    }

    mainbox {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     20px;
        border-radius:               0px 0px 0px 0px;
        background-color:            transparent;
        children:                    [ "inputbar", "message", "custombox" ];
    }

    custombox {
        spacing:                     10px;
        background-color:            transparent;
        text-color:                  @selected;
        orientation:                 horizontal;
        children:                    [ "mode-switcher", "listview" ];
    }

    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     14px 20px;
        border-radius:               8px;
        border-color: 		           @border;
        border:			                 1px;
        background-color:            @background-alt;
        text-color:                  @selected;
        children:                    [ "textbox-prompt-colon", "entry" ];
    }

    prompt {
        enabled:                     true;
        background-color:            transparent;
        text-color:                  inherit;
    }

    textbox-prompt-colon {
        enabled:                     true;
        padding:                     5px 9px 0px 2px;
        expand:                      false;
        str:                         " ";
        background-color:            transparent;
        text-color:                  @selected;
    }

    entry {
        enabled:                     true;
        padding:                     5px 0px;
        background-color:            transparent;
        text-color:                  @selected;
        cursor:                      text;
        placeholder:                 "Search...";
        font:                        inherit;
        placeholder-color:           @selected;
    }

    num-filtered-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }

    textbox-num-sep {
        enabled:                     true;
        expand:                      false;
        str:                         "/";
        background-color:            inherit;
        text-color:                  inherit;
    }

    num-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }

    case-indicator {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }

    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       7;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   true;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;

        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border-radius:               0px;
        background-color:            transparent;
        text-color:                  @selected;
        cursor:                      "default";
    }
    scrollbar {
        handle-width:                3px;
        handle-color:                @selected;
        border-radius:               10px;
        border-color: 		           @border;
        border:			                 1px;
        background-color:            @background-alt;
    }

    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     10px;
        border-radius:               8px;
        background-color:            transparent;
        text-color:                  @selected;
        cursor:                      pointer;
    }

    element normal.normal {
        background-color:            @background-alt;
        text-color:                  @selected;
        border-color:		             @border;
        border:			                 1px;
    }

    element alternate.normal {
        background-color:            @background-alt;
        text-color:                  @selected;
        border-color:		             @border;
        border:			                 1px;
    }

    element selected.normal {
        background-color:            @selected;
        text-color:                  @background;
    }

    element normal.urgent {
        background-color:            @background-alt;
        text-color:                  @urgent;
        border-color:		             @border;
        border:			                 1px;
    }

    element alternate.urgent {
        background-color:            @background-alt;
        text-color:                  @urgent;
        border-color:		             @border;
        border:			                 1px;
    }

    element selected.urgent {
        background-color:            @urgent;
        text-color:                  @background;
    }

    element normal.active {
        background-color:            @background-alt;
        text-color:                  @selected;
        border-color:		             @border;
        border:			                 1px;
    }

    element alternate.active {
        background-color:            @background-alt;
        text-color:                  @selected;
        border-color:		             @border;
        border:			                 1px;
    }

    element selected.active {
        background-color:            @selected;
        text-color:                  @background;
    }

    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        24px;
        cursor:                      inherit;
    }

    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    mode-switcher{
        enabled:                     true;
        expand:                      false;
        orientation:                 vertical;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px 0px;
        border-radius:               0px;
        background-color:            transparent;
        text-color:                  @selected;
    }

    button {
        padding:                     0px 20px 0px 20px;
        border-radius:               8px;
        border-color:		             @border;
        border:			                 1px;
        background-color:            @background-alt;
        text-color:                  inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        cursor:                      pointer;
    }

    button selected {
        background-color:            @selected;
        text-color:                  @background;
    }

    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border-color:	        	     @border;
        border:			                 1px;
        border-radius:               8px;
        background-color:            transparent;
        text-color:                  @selected;
    }

    textbox {
        padding:                     12px;
        border-radius:               8px;
        background-color:            @background-alt;
        text-color:                  @selected;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        placeholder-color:           @foreground;
        blink:                       true;
        markup:                      true;
    }

    error-message {
        padding:                     10px;
        border:                      2px solid;
        border-radius:               8px;
        border-color:                @selected;
        background-color:            @background;
        text-color:                  @urgent;
    }
  '';
}
