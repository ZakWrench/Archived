#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 15 13:03:54 2022

@author: zak
"""

import dash
import  dash_bootstrap_components as dbc
from dash import html

app = dash.Dash(external_stylesheets = [ dbc.themes.FLATLY],)

COVID_IMG = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbigredmarkets.com%2Fwp-content%2Fuploads%2F2020%2F03%2FCovid-19.png&f=1&nofb=1"

navbar = dbc.Navbar( id = 'navbar', children = [

html.A(
    dbc.Row([
        dbc.Col(html.Img(src = COVID_IMG, height = "70px")),
        dbc.Col(
            dbc.NavbarBrand("Covid-19 Live Tracker", style = {'color':'black', 'fontSize':'25px','fontFamily':'Times New Roman'}
                            )
            
            )
        
        
        ],align = "center",
        className="g-0"),
    href = '/',
    ),
    dbc.Button(id = 'button', children = "Support Us", color = "primary", className = 'ml-auto', href = '/')    
    
    ])


app.layout = html.Div(id = 'parent', children = [navbar])


if __name__ == "__main__":
    app.run_server()













