#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul 13 12:16:16 2022

@author: zak
"""

import dash
import dash_bootstrap_components as dbc
from dash import html

app = dash.Dash(external_stylesheets = [dbc.themes.FLATLY])

PLOTLY_LOGO = "https://images.plot.ly/logo/new-branding/plotly-logomark.png"

navbar = dbc.Navbar( id = 'navbar', children = [
    dbc.Row([
        dbc.Col(html.Img(src = PLOTLY_LOGO, height = "70px")),
        dbc.Col(
            dbc.NavbarBrand("App Title", style = {'color': 'black', 'fontSize': '25px', 
                                                  'fontFamily': 'Times New Roman'})
            
            
            
            )
        
        
        
        
        ], align = "center",
        className="g-3"),
    dbc.Button(id = 'button', children = "Click Me!", color = "primary"
               , className = 'ml-auto')
    
    
    
    ])

app.layout = html.Div(id = 'parent', children = [navbar])









if __name__ == "__main__":
    app.run_server()