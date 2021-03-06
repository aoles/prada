barploterrbar <- function(y, yl, yh, barcol="orange", errcol="black", horiz=FALSE, w=0.2, ylim=c(0, max(yh)*1.05), ...) {
 barplot(y, space=0.2, width=1, col=barcol, horiz=horiz, ylim=ylim, ...)
 x <- 1.2*seq(along=y) - 0.5
 lwd <- 3
 if(!horiz) {
   segments(x,   yl, x,   yh, lwd=lwd, col=errcol)
   segments(x-w, yl, x+w, yl, lwd=lwd, col=errcol)
   segments(x-w, yh, x+w, yh, lwd=lwd, col=errcol)
 } else {
   segments(yl, x,   yh, x,   lwd=lwd, col=errcol)
   segments(yl, x-w, yl, x+w, lwd=lwd, col=errcol)
   segments(yh, x-w, yh, x+w, lwd=lwd, col=errcol)
 }
}
