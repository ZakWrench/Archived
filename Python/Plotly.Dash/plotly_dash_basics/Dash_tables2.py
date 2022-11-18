#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 15 09:24:17 2022

@author: zak
"""

import dash
from dash import html
from dash import dash_table
import pandas as pd


df = pd.read_csv("https://raw.githubusercontent.com/plotly/datasets/master/multiple_y_axis.csv")

app = dash.Dash()

table = dash_table.DataTable(
    data = df.to_dict('records'),
    columns = [{'id':c, 'name':c} for c in df.columns],
    
    fixed_rows = {'headers':True},
    
    style_table = {'maxHeight':'450px'},
    
    style_header = {'backgroundColor': 'rgb(224,224,224',
                    'fontWeight':'bold', 'border':'4px solid white'},
    style_data_conditional = [
        { 'if':{'row_index':'odd'},
         'backgroundColor':'rgb(224,224,224)',
         'fontSize':'15px'
            
            },
        {'if':{'row_index':'even'},
         'backgroundColor':'rgb(255,255,255)',
         'fontSize':'15px'
         }
        
        ],
   #centering cases and making them look neat
    style_cell = {
        'textAlign':'center',
        'border':'4px solid white'
        }
    
    
    )


app.layout = html.Div(id = 'parent_div', children = [table])



if __name__ == '__main__':
    app.run_server()


















