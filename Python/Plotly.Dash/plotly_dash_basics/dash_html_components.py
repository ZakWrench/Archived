#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 12:48:43 2022

@author: zak
"""

import dash
from dash import html


app = dash.Dash()

app.layout = html.Div(id = 'parent', children = [
    
    #H1
    html.H1(id = 'H1', children = 'Hello this is an H1 tag', style = {'textAlign': 'center'}),
    
    #H2
    html.H2(id = 'H2', children = 'This is an H2 tag', style = {'textAlign':'center'}),
    
    #Paragraph
    html.P(id = 'para', children = 'This is a paragraph', style = {'textAlign':'center'}),
    
    #line break
    html.Br(),
    
    #link
    html.Div(id = 'link_div', children =[html.A(id = 'link', children = 'Google link', href = 'https://google.com', style = {'fontSize':30})],
             style = {'textAlign':'center'}),
    #image
    html.Img(id = 'image', src = "https://upload.wikimedia.org/wikipedia/commons/archive/5/53/20210618182605%21Google_%22G%22_Logo.svg", height = '50px'),
    
    #Rolling text
    html.Marquee(id = 'marquee', children = 'Hello! this can be used to show some nofication')
    
    
    
    
    ])


if __name__ == '__main__':
    app.run_server()