#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jul 12 14:48:14 2022

@author: zak
"""

import plotly.express as px
from plotly.offline import init_notebook_mode, plot
init_notebook_mode()


df = px.data.gapminder().query("year == 2007")

fig = px.choropleth(df, locations = 'iso_alpha', color = "lifeExp",
                    hover_name = "country", projection = "orthographic",
                    color_continuous_scale = px.colors.sequential.Plasma)

plot(fig)