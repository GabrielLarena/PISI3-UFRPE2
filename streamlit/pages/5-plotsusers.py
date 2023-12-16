import pandas as pd
import numpy as np
import streamlit as st
import plotly.express as px
import plotly.graph_objects as go

df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")

def boxplot(df_user):
    st.markdown('<h3>Diagrama de Caixa (<i>Boxplot</i>)</h3>', unsafe_allow_html=True)
    c1, c2 = st.columns([.3,.7])
    cols = ['Days Watched', 'Mean Score', 'Episodes Watched', 'Completed', 'Dropped']
    serie_col = c1.selectbox('Série*', options=cols, key='serie_2')
    cols = [serie_col, 'Gender']
    cols.reverse()
    df_plot = df_user[cols]
    fig = px.box(df_plot,x=cols[0],y=cols[1])
    if serie_col == "Mean Score":
        fig.update_layout(yaxis_range=[0, 10])
    elif serie_col == "Days Watched":
        fig.update_layout(yaxis_range=[0, 200])
    elif serie_col == "Completed":
        fig.update_layout(yaxis_range=[0, 700])
    elif serie_col == "Dropped":
        fig.update_layout(yaxis_range=[0, 60])
    else:
        fig.update_layout(yaxis_range=[0, 13000])

    #fig.update_layout(yaxis_range=[0, 10000])
    c2.plotly_chart(fig, use_container_width=True)
    st.write("TODO: adicionar idade do usuário, idade da conta")

boxplot(df_user)