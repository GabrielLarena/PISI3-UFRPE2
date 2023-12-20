import streamlit as st
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load Parquet file
file_path = 'C:\\Users\\eu7eu\\Desktop\\Projetos\\parquet'
df = pd.read_parquet(file_path)

# Filter out rows with score equal to 0
new_df = df[df['score'] != 0]

# Sidebar controls (optional)
st.sidebar.header("Visualization Settings")
column_name = st.sidebar.selectbox("Select Column for Visualization", df.columns)

# Main content
st.title("Streamlit App with KDE Plot")

# KDE plot
sns.set(style="whitegrid")
fig, ax = plt.subplots()
sns.kdeplot(data=new_df, x=column_name, fill=True, ax=ax)
ax.set(title=f"KDE Plot for {column_name}")
st.pyplot(fig)

# Additional information or analysis (optional)
st.write("Additional Information:")
st.write(f"Mean {column_name}: {new_df[column_name].mean()}")
st.write(f"Median {column_name}: {new_df[column_name].median()}")