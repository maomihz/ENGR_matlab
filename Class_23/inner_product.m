function result = inner_product(vectorX, vectorY)
%INNER_PRODUCT compute the inner product between two vectors
%   INNER_PRODUCT(X,Y) computes the inner product between two vectors. The inner
%   product of two vectors is defined as the sum of products between all
%   components of vector X and Y (Is a generalization of the dot product)
%   (http://mathworld.wolfram.com/InnerProduct.html)
%
%   INNER_PRODUCT has the following inputs:
%       X - the first vector
%       Y - the second vector
%   The two vectors should both be row-vector and has the same dimension
%
%   INNER_PRODUCT has the following outputs"
%       result - the inner product of the vectors

    result = sum(vectorX .* vectorY);
end
