import pandas as pd
import numpy as np
import streamlit as st
import plotly.express as px
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.graph_objects as go
from sklearn.cluster import KMeans
from sklearn.preprocessing import MinMaxScaler

def main():
    st.title('Análise de Clustering de Animes')

    # Load the Parquet data into a pandas DataFrame
    df = pd.read_parquet('data/preprocessamento/AnimeList2023.parquet')

    # Explanation text
    st.write("Neste aplicativo, usamos o algoritmo K-Means para agrupar animes com base em seus anos de lançamento e pontuações.")
    st.write("Aqui está um gráfico de dispersão mostrando os clusters formados.")

    # Select the 'Release Year' and 'Score' columns for clustering
    X = df[['Release Year', 'Score']]

    # Standardize the data to have zero mean and unit variance
    scaler = MinMaxScaler()
    X_scaled = scaler.fit_transform(X)

    # Specify the number of clusters (you can adjust this based on your needs)
    n_clusters = 6

    # Apply k-means clustering
    kmeans = KMeans(n_clusters=n_clusters, random_state=42)
    df['Cluster'] = kmeans.fit_predict(X_scaled)

    # Visualize the clusters
    fig, ax = plt.subplots(figsize=(10, 6))
    for cluster in range(n_clusters):
        cluster_data = df[df['Cluster'] == cluster]
        ax.scatter(cluster_data['Release Year'], cluster_data['Score'], label=f'Cluster {cluster + 1}')

    ax.scatter(scaler.inverse_transform(kmeans.cluster_centers_)[:, 0], scaler.inverse_transform(kmeans.cluster_centers_)[:, 1],
                s=200, c='black', label='Centroids')
    ax.set_title('K-Means Cluster of Anime Data')
    ax.set_xlabel('Year')
    ax.set_ylabel('Score')
    ax.legend()
    ax.grid(True)

    st.pyplot(fig)

    # Explanation text for elbow plot
    st.write("Aqui está um gráfico do método do cotovelo para ajudar a escolher o número ideal de clusters.")

    # Load the CSV data into a pandas DataFrame
    df_csv = pd.read_csv('data/preprocessamento/AnimeList2023.csv')

    # Select the 'Score' and 'Release Year' columns for clustering
    X_csv = df_csv[['Score', 'Release Year']]

    # Standardize the data to have zero mean and unit variance
    scaler_csv = MinMaxScaler()
    X_scaled_csv = scaler_csv.fit_transform(X_csv)

    # Specify a range of clusters to try
    max_clusters = 10
    inertia_values = []

    # Try different numbers of clusters and record the inertia
    for i in range(1, max_clusters + 1):
        kmeans = KMeans(n_clusters=i, random_state=42)
        kmeans.fit(X_scaled_csv)
        inertia_values.append(kmeans.inertia_)

    # Plot the elbow curve
    fig_elbow, ax_elbow = plt.subplots(figsize=(10, 6))
    ax_elbow.plot(range(1, max_clusters + 1), inertia_values, marker='o')
    ax_elbow.set_title('Elbow Plot para o número de clusters')
    ax_elbow.set_xlabel('Número de Clusters')
    ax_elbow.set_ylabel('Inércia')
    ax_elbow.grid(True)

    st.pyplot(fig_elbow)

if __name__ == "__main__":
    main()
