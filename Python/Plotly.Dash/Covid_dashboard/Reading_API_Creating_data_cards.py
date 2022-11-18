#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jul 16 20:57:00 2022

@author: zak
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Jul 15 13:03:54 2022

@author: zak
"""

import dash
import  dash_bootstrap_components as dbc
from dash import html
import requests 
import pandas as pd
from dash import dcc

app = dash.Dash(external_stylesheets = [ dbc.themes.FLATLY],)

COVID_IMG = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fbigredmarkets.com%2Fwp-content%2Fuploads%2F2020%2F03%2FCovid-19.png&f=1&nofb=1"

url = "https://api.covid19api.com/summary"
response_world = requests.request("GET", url)
df_countries = pd.DataFrame(response_world.json()['Countries'])
df_global = pd.DataFrame(response_world.json()['Global'], index = [0])
df_last_updated = response_world.json()['Date']

confirmed = df_global['TotalConfirmed'][0]
newconfirmed = df_global['NewConfirmed'][0]
death = df_global['TotalDeaths'][0]
newdeaths = df_global['NewDeaths'][0]
recovered = df_global['TotalRecovered'][0]
newrecovered = df_global['NewRecovered'][0]


def data_for_cases(header, total_cases, new_cases):
    card_content = [
        dbc.CardHeader(header),
        
        dbc.CardBody(
            [
               dcc.Markdown(dangerously_allow_html = True, 
                            children = ["{0} <br><sub>+{1}</sub></br>".format(total_cases, new_cases)]) 
                
                
                ]
            )
        
        
        ]
    return card_content



body_app = dbc.Container([
    
    dbc.Row(html.Marquee("USA, India and Brazil are top 3 countries in term of confirmed cases"), style = {
        'color':'green'}),
    
    dbc.Row([
        
        dbc.Col(dbc.Card(data_for_cases("Confirmed",f'{confirmed:,}',f'{newconfirmed:,}'), color = 'primary',
                         style = {'text-align':'center'}, inverse = True)),
        dbc.Col(dbc.Card(data_for_cases("Recovered",f'{recovered:,}', f'{newrecovered:,}'), color = 'success',
                         style = {'text-align':'center'}, inverse = True)),
        dbc.Col(dbc.Card(data_for_cases("Deaths",f'{death:,}',f'{newdeaths:,}'), color = 'danger',
                         style = {'text-align':'center'}, inverse = True)),
        
        ],
        #fluid = True
        )
    
    
    
    
    
    
    ])


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


app.layout = html.Div(id = 'parent', children = [navbar,body_app])


if __name__ == "__main__":
    app.run_server()













