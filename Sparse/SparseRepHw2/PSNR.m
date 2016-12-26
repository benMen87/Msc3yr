<<<<<<< HEAD
function [psnr__] = PSNR(y , y_hat)
    s = sqrt(length(y));
    dr = (max(y) - min(y)) ;

    psnr__ = db(s^2*dr / ((y - y_hat)' * (y - y_hat)));

    function db__ = db(x)
        db__ = 10*log10(x);
    end
end
=======
function [psnr__] = PSNR(y , y_hat)
    s = sqrt(length(y));
    dr = (max(y) - min(y)) ;

    psnr__ = db(s^2*dr / ((y - y_hat)' * (y - y_hat)));

    function db__ = db(x)
        db__ = 10*log10(x);
    end
end
>>>>>>> 3df8b6efa9779d09089a22950b2f1c62f4a57f92
