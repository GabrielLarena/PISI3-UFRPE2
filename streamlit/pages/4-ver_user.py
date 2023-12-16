import streamlit as st
import pandas as pd

df_user = pd.read_parquet("data/preprocessamento/UserList.parquet")

st.title("Consultar usuário")
user = st.selectbox("Selecione o Usuário: ", df_user['Username'])

if user:
    df_user.set_index('Mal ID', inplace=True)
    user_info = df_user.loc[df_user["Username"] == user]
    
    st.title(f"{user_info.iloc[0]['Username']}")
    st.write(f"Genero: {user_info.iloc[0]['Gender']}")

    st.write(f"Aniversário: {user_info.iloc[0]['Birthday']}")

    st.write(f"Data de criação da conta: {user_info.iloc[0]['Joined']}")

    st.write(f"Quanto tempo em horas assistindo anime: {(user_info.iloc[0]['Days Watched'] * 24):.0f} horas")

    st.write(f"Média de nota: {user_info.iloc[0]['Mean Score']}")

    st.write(f"Animes Completados: {(user_info.iloc[0]['Completed']):.0f}")

    st.write(f"Animes abandonados: {(user_info.iloc[0]['Dropped']):.0f}")

    st.write(f"Número de episódios assistidos: {(user_info.iloc[0]['Episodes Watched']):.0f}")

else:
    st.write("Selecione um usuário")