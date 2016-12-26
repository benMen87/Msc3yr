
function mse__ = MSE(x, x_hat)
    mse__ = (x - x_hat)' * (x - x_hat) / (x' * x);
end