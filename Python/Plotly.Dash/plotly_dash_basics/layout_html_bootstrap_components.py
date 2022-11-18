#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 15:52:29 2022

@author: zak
"""

import dash
from dash import html
import plotly.graph_objects as go
import plotly.express as px
import dash_bootstrap_components as dbc
import dash_core_components as dcc


app = dash.Dash(external_stylesheets=[dbc.themes.FLATLY])


df = px.data.gapminder().query("country =='India'")
df2 = px.data.gapminder().query("country =='Morocco'")

def bar_chart(df,df2):
    fig = go.Figure([go.Bar(x = df['year'], y = df['gdpPercap'], marker_color = 'indianred', name = 'India'),
                     go.Bar(x = df2['year'], y = df2['gdpPercap'], marker_color = 'blue', name = 'Morocco')])

    fig.update_layout(title = 'GDP per catipa over the years',
                      xaxis_title = 'Years',
                      yaxis_title = 'GDP per capita',
                      barmode = 'group')
    return fig


def line_chart(df,df2):
    fig = go.Figure(data = [go.Scatter(x = df['year'], y = df['lifeExp'],
                                       line = dict(color = 'firebrick', width = 4),
                                       text = df['country'], name = 'India'),
                            go.Scatter(x = df2['year'], y = df2['lifeExp'],
                                       line = dict(color = 'blue', width = 4),
                                       text = df2['country'], name = 'Morocco')])

    fig.update_layout(title = 'Life expectency over the years',
                      xaxis_title = 'Years',
                      yaxis_title = 'Life expectancy (years)',)
    return fig



app.layout = dbc.Container([
    dbc.Row([dbc.Col([html.H1(id = 'H1', children = 'Styling using bootstrap components')], xl=12, lg = 12, md = 12, sm =12, xs = 12
                     )],style = {'textAlign':'center', 'marginTop': '30', 'marginBottom':'30'}),
    
    dbc.Row([
        dbc.Col([dcc.Graph(id = 'bar_plot', figure = bar_chart(df, df2))], xl=6, lg = 6, md = 6, sm =12, xs = 12),
        dbc.Col([dcc.Graph(id = 'line_plot', figure = line_chart(df, df2))],xl = 6, lg = 6, md = 6, sm = 12, xs = 12)
        
        ], #fluid = True
        )
    
    ])
    

if __name__ == '__main__':
    app.run_server()
















