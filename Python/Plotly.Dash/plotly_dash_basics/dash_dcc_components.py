#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 13:13:12 2022

@author: zak
"""

import dash
from dash import html
import dash_core_components as dcc
from datetime import datetime as dt

app = dash.Dash()

app.layout = html.Div([
    
    #dropdown
    html.Div(id = 'dropdown_div', children = [dcc.Dropdown( id = 'dropdown',
        options = [
            {'label':'amazing', 'value':'5'},
            {'label': 'average', 'value': '3'},
            {'label': 'below average', 'value': '1', 'disabled':True}
            
            
            
            
            ],
        value = 'amazing',
        placeholder = 'select rating for the course',
        multi = True
        
        
        )], style = {'width':'50%'}),
    
    html.Br(),
    
    dcc.Slider( id = 'slider',
        min = 0,
        max = 10,
        step = 1,
        value = 0,
        marks = {i: '{}'.format(i) for i in range(11)}
        
        ),
    
    html.Br(),
    
    dcc.Input(id = 'input',
              type = 'text',
              placeholder = 'Enter your text',
              value = '',
              debounce = True,
              ),
    html.Br(),
    
    dcc.Checklist(id = 'checklist',
                  options = [
                      {'label':'amazing', 'value':'5'},
                      {'label': 'average', 'value': '3'},
                      {'label': 'below average', 'value': '1', 'disabled':True}
                  
                      
                      
                      
                      ],
                  value = ['5', '3']
                  
                  
                  ),
    
    html.Br(),
    
    dcc.DatePickerRange(id = 'date_pick_range',
                        start_date = dt(1997,5,3),
                        #end_date_placeholder_text = 'Select a date',
                        min_date_allowed = dt(1993,5,6),
                        max_date_allowed = dt(2022,12,7)
                        ),
    
    html.Br(),
    
    dcc.Markdown(id = 'markdown', children = ['''
 # Dash and Markdown

## *italicsDash supports [Markdown](http://commonmark.org/help).*

### Markdown is a simple way to write and format text.
It includes a syntax for things like **bold text** and *italics*,
[links](http://commonmark.org/help), inline `code` snippets, lists,
quotes, and more.'''] )
    
    ])


if __name__ == '__main__':
    app.run_server()
    
