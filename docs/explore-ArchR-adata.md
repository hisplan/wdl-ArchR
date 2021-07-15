```python
import scanpy as sc
import pandas as pd
```

# Load AnnData


```python
adata = sc.read_h5ad("preprocessed.h5ad")
```


```python
adata
```




    AnnData object with n_obs × n_vars = 4579 × 178946
        obs: 'Sample', 'nMultiFrags', 'nMonoFrags', 'nFrags', 'nDiFrags', 'TSSEnrichment', 'ReadsInTSS', 'ReadsInPromoter', 'ReadsInBlacklist', 'PromoterRatio', 'PassQC', 'NucleosomeRatio', 'BlacklistRatio', 'Clusters'
        var: 'seqnames', 'start', 'end', 'width', 'strand', 'distToGeneStart', 'nearestGene', 'peakType', 'distToTSS', 'nearestTSS', 'replicateScoreQuantile'
        uns: 'GeneScoresColumns'
        obsm: 'GeneScores', 'X_svd', 'umap'



# Explore AnnData

## obs


```python
adata.obs
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Sample</th>
      <th>nMultiFrags</th>
      <th>nMonoFrags</th>
      <th>nFrags</th>
      <th>nDiFrags</th>
      <th>TSSEnrichment</th>
      <th>ReadsInTSS</th>
      <th>ReadsInPromoter</th>
      <th>ReadsInBlacklist</th>
      <th>PromoterRatio</th>
      <th>PassQC</th>
      <th>NucleosomeRatio</th>
      <th>BlacklistRatio</th>
      <th>Clusters</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>DACE657_mKate2#GGAGTCTGTTTGGGCG-1</th>
      <td>DACE657_mKate2</td>
      <td>127326</td>
      <td>380482</td>
      <td>956946</td>
      <td>449138</td>
      <td>2.936</td>
      <td>11325</td>
      <td>66220</td>
      <td>37633</td>
      <td>0.034600</td>
      <td>1</td>
      <td>1.515089</td>
      <td>0.019663</td>
      <td>C4</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#ATTCAACCAGGTATTT-1</th>
      <td>DACE657_mKate2</td>
      <td>57136</td>
      <td>633366</td>
      <td>861039</td>
      <td>170537</td>
      <td>1.119</td>
      <td>3236</td>
      <td>32952</td>
      <td>36300</td>
      <td>0.019135</td>
      <td>1</td>
      <td>0.359465</td>
      <td>0.021079</td>
      <td>C2</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#ACATTGCAGGGATGAC-1</th>
      <td>DACE657_mKate2</td>
      <td>57182</td>
      <td>600534</td>
      <td>823762</td>
      <td>166046</td>
      <td>1.938</td>
      <td>6229</td>
      <td>47176</td>
      <td>33188</td>
      <td>0.028634</td>
      <td>1</td>
      <td>0.371716</td>
      <td>0.020144</td>
      <td>C14</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CTCTTGATCTTGTCCA-1</th>
      <td>DACE657_mKate2</td>
      <td>22834</td>
      <td>697688</td>
      <td>819298</td>
      <td>98776</td>
      <td>2.809</td>
      <td>9524</td>
      <td>57701</td>
      <td>32171</td>
      <td>0.035214</td>
      <td>1</td>
      <td>0.174304</td>
      <td>0.019633</td>
      <td>C2</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#GTCATCACATGCATAT-1</th>
      <td>DACE657_mKate2</td>
      <td>105585</td>
      <td>332298</td>
      <td>642036</td>
      <td>204153</td>
      <td>10.578</td>
      <td>51937</td>
      <td>225568</td>
      <td>19204</td>
      <td>0.175666</td>
      <td>1</td>
      <td>0.932109</td>
      <td>0.014956</td>
      <td>C4</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CGCATTTGTTCGCGCT-1</th>
      <td>DACE657_mKate2</td>
      <td>66</td>
      <td>575</td>
      <td>1002</td>
      <td>361</td>
      <td>2.871</td>
      <td>29</td>
      <td>125</td>
      <td>32</td>
      <td>0.062375</td>
      <td>1</td>
      <td>0.742609</td>
      <td>0.015968</td>
      <td>C14</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#TGTCATAAGGGACTAA-1</th>
      <td>DACE657_mKate2</td>
      <td>59</td>
      <td>526</td>
      <td>1002</td>
      <td>417</td>
      <td>4.059</td>
      <td>41</td>
      <td>186</td>
      <td>36</td>
      <td>0.092814</td>
      <td>1</td>
      <td>0.904943</td>
      <td>0.017964</td>
      <td>C14</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CGCAAATTCGTCATTT-1</th>
      <td>DACE657_mKate2</td>
      <td>87</td>
      <td>625</td>
      <td>1001</td>
      <td>289</td>
      <td>15.239</td>
      <td>177</td>
      <td>626</td>
      <td>41</td>
      <td>0.312687</td>
      <td>1</td>
      <td>0.601600</td>
      <td>0.020480</td>
      <td>C15</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CATCGCTTCCGGTATG-1</th>
      <td>DACE657_mKate2</td>
      <td>62</td>
      <td>548</td>
      <td>1000</td>
      <td>390</td>
      <td>4.356</td>
      <td>44</td>
      <td>169</td>
      <td>24</td>
      <td>0.084500</td>
      <td>1</td>
      <td>0.824818</td>
      <td>0.012000</td>
      <td>C14</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CTATGGCCACGTTACA-1</th>
      <td>DACE657_mKate2</td>
      <td>109</td>
      <td>382</td>
      <td>1000</td>
      <td>509</td>
      <td>2.871</td>
      <td>29</td>
      <td>111</td>
      <td>46</td>
      <td>0.055500</td>
      <td>1</td>
      <td>1.617801</td>
      <td>0.023000</td>
      <td>C14</td>
    </tr>
  </tbody>
</table>
<p>4579 rows × 14 columns</p>
</div>



## obs_names


```python
adata.obs_names
```




    Index(['DACE657_mKate2#GGAGTCTGTTTGGGCG-1',
           'DACE657_mKate2#ATTCAACCAGGTATTT-1',
           'DACE657_mKate2#ACATTGCAGGGATGAC-1',
           'DACE657_mKate2#CTCTTGATCTTGTCCA-1',
           'DACE657_mKate2#GTCATCACATGCATAT-1',
           'DACE657_mKate2#AGCTACGTCCAAATCA-1',
           'DACE657_mKate2#AGGATTGAGCTACTGG-1',
           'DACE657_mKate2#TGTATCGCACCCACAG-1',
           'DACE657_mKate2#AAACCGCGTAACTACG-1',
           'DACE657_mKate2#AATGCAACACGTAATT-1',
           ...
           'DACE657_mKate2#GCGTGCTAGGCTATGT-1',
           'DACE657_mKate2#GGTAAACCAGGCTAAG-1',
           'DACE657_mKate2#GTGCCTTTCCACCTTA-1',
           'DACE657_mKate2#TGTGGCTCAGAAACGT-1',
           'DACE657_mKate2#TTTCCACCAGCACGAA-1',
           'DACE657_mKate2#CGCATTTGTTCGCGCT-1',
           'DACE657_mKate2#TGTCATAAGGGACTAA-1',
           'DACE657_mKate2#CGCAAATTCGTCATTT-1',
           'DACE657_mKate2#CATCGCTTCCGGTATG-1',
           'DACE657_mKate2#CTATGGCCACGTTACA-1'],
          dtype='object', length=4579)



## var


```python
adata.var
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>seqnames</th>
      <th>start</th>
      <th>end</th>
      <th>width</th>
      <th>strand</th>
      <th>distToGeneStart</th>
      <th>nearestGene</th>
      <th>peakType</th>
      <th>distToTSS</th>
      <th>nearestTSS</th>
      <th>replicateScoreQuantile</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Peak1</th>
      <td>chr1</td>
      <td>3481922</td>
      <td>3482422</td>
      <td>501</td>
      <td>*</td>
      <td>267690</td>
      <td>Xkr4</td>
      <td>Intronic</td>
      <td>176731</td>
      <td>uc007afg.1</td>
      <td>0.114</td>
    </tr>
    <tr>
      <th>Peak2</th>
      <td>chr1</td>
      <td>3493610</td>
      <td>3494110</td>
      <td>501</td>
      <td>*</td>
      <td>279378</td>
      <td>Xkr4</td>
      <td>Intronic</td>
      <td>165043</td>
      <td>uc007afg.1</td>
      <td>0.327</td>
    </tr>
    <tr>
      <th>Peak3</th>
      <td>chr1</td>
      <td>3514773</td>
      <td>3515273</td>
      <td>501</td>
      <td>*</td>
      <td>300541</td>
      <td>Xkr4</td>
      <td>Intronic</td>
      <td>143880</td>
      <td>uc007afg.1</td>
      <td>0.965</td>
    </tr>
    <tr>
      <th>Peak4</th>
      <td>chr1</td>
      <td>3516762</td>
      <td>3517262</td>
      <td>501</td>
      <td>*</td>
      <td>302530</td>
      <td>Xkr4</td>
      <td>Intronic</td>
      <td>141891</td>
      <td>uc007afg.1</td>
      <td>0.676</td>
    </tr>
    <tr>
      <th>Peak5</th>
      <td>chr1</td>
      <td>3534649</td>
      <td>3535149</td>
      <td>501</td>
      <td>*</td>
      <td>320417</td>
      <td>Xkr4</td>
      <td>Intronic</td>
      <td>124004</td>
      <td>uc007afg.1</td>
      <td>0.835</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>Peak178942</th>
      <td>chrX</td>
      <td>169936383</td>
      <td>169936883</td>
      <td>501</td>
      <td>*</td>
      <td>251434</td>
      <td>Mid1</td>
      <td>Intronic</td>
      <td>9678</td>
      <td>uc009rcn.1</td>
      <td>0.113</td>
    </tr>
    <tr>
      <th>Peak178943</th>
      <td>chrX</td>
      <td>169937107</td>
      <td>169937607</td>
      <td>501</td>
      <td>*</td>
      <td>252158</td>
      <td>Mid1</td>
      <td>Intronic</td>
      <td>10402</td>
      <td>uc009rcn.1</td>
      <td>0.775</td>
    </tr>
    <tr>
      <th>Peak178944</th>
      <td>chrX</td>
      <td>169937886</td>
      <td>169938386</td>
      <td>501</td>
      <td>*</td>
      <td>252937</td>
      <td>Mid1</td>
      <td>Intronic</td>
      <td>11181</td>
      <td>uc009rcn.1</td>
      <td>0.586</td>
    </tr>
    <tr>
      <th>Peak178945</th>
      <td>chrX</td>
      <td>169950318</td>
      <td>169950818</td>
      <td>501</td>
      <td>*</td>
      <td>265369</td>
      <td>Mid1</td>
      <td>Intronic</td>
      <td>22316</td>
      <td>uc009rcn.1</td>
      <td>0.724</td>
    </tr>
    <tr>
      <th>Peak178946</th>
      <td>chrX</td>
      <td>169961044</td>
      <td>169961544</td>
      <td>501</td>
      <td>*</td>
      <td>276095</td>
      <td>Mid1</td>
      <td>Intronic</td>
      <td>11590</td>
      <td>uc009rcn.1</td>
      <td>0.668</td>
    </tr>
  </tbody>
</table>
<p>178946 rows × 11 columns</p>
</div>



## obsm


```python
adata.obsm
```




    AxisArrays with keys: GeneScores, X_svd, umap



## uns


```python
adata.uns
```




    OverloadedDict, wrapping:
    	{'GeneScoresColumns': array(['Xkr4', 'Rp1', 'Sox17', ..., 'Mid1', '4933400A11Rik', 'Asmt'],
          dtype=object)}
    With overloaded keys:
    	['neighbors'].



# Gene Scores


```python
adata.obsm["GeneScores"].shape
```




    (4579, 24333)




```python
adata.uns["GeneScoresColumns"]
```




    array(['Xkr4', 'Rp1', 'Sox17', ..., 'Mid1', '4933400A11Rik', 'Asmt'],
          dtype=object)




```python
adata.uns["GeneScoresColumns"].shape
```




    (24333,)




```python
df_gene_scores = pd.DataFrame(
    adata.obsm["GeneScores"],
    columns=adata.uns["GeneScoresColumns"],
    index=adata.obs_names
)
df_gene_scores
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Xkr4</th>
      <th>Rp1</th>
      <th>Sox17</th>
      <th>Mrpl15</th>
      <th>Lypla1</th>
      <th>Tcea1</th>
      <th>Rgs20</th>
      <th>Atp6v1h</th>
      <th>Oprk1</th>
      <th>Npbwr1</th>
      <th>...</th>
      <th>Prps2</th>
      <th>Frmpd4</th>
      <th>Msl3</th>
      <th>Arhgap6</th>
      <th>Amelx</th>
      <th>Hccs</th>
      <th>Gm15246</th>
      <th>Mid1</th>
      <th>4933400A11Rik</th>
      <th>Asmt</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>DACE657_mKate2#GGAGTCTGTTTGGGCG-1</th>
      <td>0.262</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.183</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.130</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.638</td>
      <td>0.693</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#ATTCAACCAGGTATTT-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>1.181</td>
      <td>1.605</td>
      <td>0.795</td>
      <td>0.0</td>
      <td>1.931</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>2.799</td>
      <td>3.039</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#ACATTGCAGGGATGAC-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.983</td>
      <td>0.000</td>
      <td>1.323</td>
      <td>0.0</td>
      <td>0.237</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.814</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>1.747</td>
      <td>1.897</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CTCTTGATCTTGTCCA-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.322</td>
      <td>0.814</td>
      <td>0.806</td>
      <td>0.0</td>
      <td>0.807</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#GTCATCACATGCATAT-1</th>
      <td>0.434</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.807</td>
      <td>0.303</td>
      <td>0.301</td>
      <td>0.0</td>
      <td>0.258</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.370</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.529</td>
      <td>0.575</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CGCATTTGTTCGCGCT-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>97.786</td>
      <td>106.150</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#TGTCATAAGGGACTAA-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CGCAAATTCGTCATTT-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CATCGCTTCCGGTATG-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
    <tr>
      <th>DACE657_mKate2#CTATGGCCACGTTACA-1</th>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>...</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.000</td>
      <td>0.000</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
    </tr>
  </tbody>
</table>
<p>4579 rows × 24333 columns</p>
</div>




```python
df_gene_scores.sum(axis=1)
```




    DACE657_mKate2#GGAGTCTGTTTGGGCG-1    10000.047
    DACE657_mKate2#ATTCAACCAGGTATTT-1     9999.985
    DACE657_mKate2#ACATTGCAGGGATGAC-1    10000.017
    DACE657_mKate2#CTCTTGATCTTGTCCA-1    10000.018
    DACE657_mKate2#GTCATCACATGCATAT-1     9999.981
                                           ...    
    DACE657_mKate2#CGCATTTGTTCGCGCT-1    10000.002
    DACE657_mKate2#TGTCATAAGGGACTAA-1    10000.000
    DACE657_mKate2#CGCAAATTCGTCATTT-1     9999.996
    DACE657_mKate2#CATCGCTTCCGGTATG-1     9999.999
    DACE657_mKate2#CTATGGCCACGTTACA-1    10000.000
    Length: 4579, dtype: float64




```python

```
