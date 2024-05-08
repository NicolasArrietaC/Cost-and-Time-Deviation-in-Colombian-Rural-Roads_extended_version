import umap, pandas as pd

# use Umap to do embedding then cluster on that
def umap_embed(df, n_components=2, intersection=False):

  numerical = df.select_dtypes(exclude='object')

  for c in numerical.columns:
      numerical[c] = (numerical[c] - numerical[c].mean())/numerical[c].std(ddof=0)
      
  ##preprocessing categorical
  categorical = df.select_dtypes(include='object')
  categorical = pd.get_dummies(categorical)

  #Embedding numerical & categorical
  fit1 = umap.UMAP(random_state=12,
                   n_components=n_components).fit(numerical)
  
  fit2 = umap.UMAP(metric='dice', 
                   n_neighbors=30,
                   n_components=n_components).fit(categorical)


  # intersection will resemble the numerical embedding more.
  if intersection:
    embedding = fit1 * fit2

  # union will resemble the categorical embedding more.
  else:
    embedding = fit1 + fit2

  umap_embedding = embedding.embedding_

  
  return umap_embedding