# -*- coding: utf-8 -*-
"""
    Gruvbox Colorscheme
    ~~~~~~~~~~~~~~~~~
    A retro groove color scheme for Vim.
    https://github.com/morhetz/gruvbox

    © 2012-2015 Pavel Pertsev
    Adapted for Pygments by Dave Yarwood

    Converted by Vim Colorscheme Converter
    https://github.com/honza/vim2pygments
"""
from pygments.style import Style
from pygments.token import Token, Comment, Name, Keyword, Generic, Number, Operator, String

class GruvboxStyle(Style):
    """ Retro groove color scheme for Vim by Github: @morhetz """

    background_color = '#222222'
    styles = {
        Comment.Special:    '#a6a501',  # Green
        Comment.Multiline:  '#7f7f7f',  # Grey
        Comment.Preproc:    '#7ca57c',  # Blue
        Comment.PreprocFile:'#a6a501',  # Green
        Comment:            '#7f7f7f',  # Grey
        Keyword.Declaration:'#111111',
        Keyword.Constant:   '#111111',
        Keyword.Namespace:  '#7ca5a5',
        Keyword.Reserved:   '#111111',
        Keyword.Type:       '#ffa502',
        Keyword:            '#d15454', # Dark Red
        Name.Variable:      '#8eaeae', # Blue
        Name.Function:      '#7ca57c',
        Name.Class:         '#7ca57c', 
        Name:               '#ffd1a6', # Light Brown
        Operator:           '#ffd1a6', # Light Brown
        Number:             '#d17ca5', # Purple
        String:             '#b8bb26', # Green
        Token:              '#ff7b02',
    }
##        Operator:           '#ffd1a6',
##        Keyword:            '#7ca5a5',
##        Comment.Preproc:    'noinherit #8ec07c',
##        Generic.Deleted:    'noinherit #282828 bg:#fb4934',
##        Generic.Emph:       '#83a598 underline',
##        Generic.Error:      'bg:#fb4934 bold',
##        Generic.Heading:    '#b8bb26 bold',
##        Generic.Inserted:   'noinherit #282828 bg:#b8bb26',
##        Generic.Output:     'noinherit #504945',
##        Generic.Prompt:     '#ebdbb2',
##        Generic.Strong:     '#ebdbb2',
##        Generic.Subheading: '#b8bb26 bold',
##        Generic.Traceback:  'bg:#fb4934 bold',
##        Number.Float:       'noinherit #d3869b',
##        Name.Attribute:     '#b8bb26 bold',
##        Name.Builtin:       '#fabd2f',
##        Name.Constant:      'noinherit #d3869b',
##        Name.Entity:        'noinherit #fabd2f',
##        Name.Exception:     'noinherit #fb4934',
##        Name.Function:      '#fabd2f',
##        Name.Label:         'noinherit #fb4934',
##        Name.Tag:           'noinherit #fb4934',
##        Name.Variable:      'noinherit #ebdbb2',
##        String.Symbol:      '#83a598',
##        Token:              'noinherit #ebdbb2 bg:#282828',
