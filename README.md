# Shapley value for reconstruction errors of PCA

This is a set of demo scripts to compute the Shapley values of reconstruction
error of PCA, with its conditional expectations as a characteristic function.

## Usage

shapely_exact.m computes the exact Shapley value based on the original definition.
shapley_mc.m performs simple Monte Carlo approximation.

Run demo.m for a simple demonstration.

## Reference

Naoya Takeishi.
Shapley values of reconstruction errors of PCA for explaining anomaly detection.
arXiv:1909.03495

The paper also also appeared in the Workshop on Learning and Mining with
Industrial Data, Beijing, November 2019. The corresponding reference is in Proc.
of ICDM Workshops, pp.793–798, 2019. (DOI: 10.1109/ICDMW.2019.00117)
However, *I recommend to refer to the arXiv version above because the workshop's
manuscript contains typos in Eqs. (14) and (18)* (sorry...).

## Further information

You may also be interested in another work on explaining anomaly detection:
https://arxiv.org/abs/2004.04464
though the approach there is slightly different.

## Author

Naoya Takeishi
https://ntake.jp/
