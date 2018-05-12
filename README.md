# bindata_rmvbin
Fix to rmvbin function in CRAN's bindata package

Couldn't get in touch with the authors; pushing this to Github in case anyone else needed the fix and so hopefully someone can make the changes in CRAN.

```r
example <- bindata::rmvbin(10000, margprob = c(0.05, 0.5), sigma = matrix(c(10000, 0, 0, 1), nrow = 2))
colSums(example)/nrow(example)
# [1] 0.4930 0.5077 # Should be roughly 0.05 and 0.5
```

This is because in that function the author forgot to take into account the variance of the marginal normals:

```r
retval <- rmvnorm(n, qnorm(margprob), as.matrix(sigma))
```

It should be:

```r
retval <- rmvnorm(n, qnorm(margprob, sd = sqrt(diag(sigma))), as.matrix(sigma))
```

See change to fixed source code for the function:
https://github.com/millerjoey/bindata_rmvbin/commit/a2713a8820c4d07b2ed989217edc04afea12c315#diff-ebfabe765ddba3de73b7e0cfa966675a
