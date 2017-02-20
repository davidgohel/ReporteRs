context("Test powerpoint color table extraction");

test_that("Colors extracted correctly",{
    p <- pptx("Matt Fidler");
    tmp <- c("#5B9BD5", "#ED7D31", "#A5A5A5", "#FFC000", "#4472C4",  "#70AD47", "#000000", "#FFFFFF", "#44546A", "#E7E6E6", "#0563C1",  "#954F72");
    names(tmp) <- c("accent1", "accent2", "accent3", "accent4",  "accent5", "accent6", "dk1", "lt1", "dk2", "lt2", "hlink", "folHlink" );
    tmp <- list(tmp);
    expect_equal(pptxColors(p), tmp);
    expect_equal(pptxColors(p, full=TRUE),
                 list(structure(c("#FFFFFF", "#F2F2F2", "#D9D9D9", "#BFBFBF",
                                  "#A6A6A6", "#808080", "#000000", "#808080", "#595959", "#404040",
                                  "#262626", "#0D0D0D", "#E7E6E6", "#FDFCFC", "#F9F9F9", "#F3F2F2",
                                  "#EDECEC", "#E9E8E8", "#44546A", "#DADDE1", "#B4BBC3", "#8F98A6",
                                  "#333F50", "#222A35", "#5B9BD5", "#DEEBF7", "#BDD7EE", "#9DC3E6",
                                  "#4474A0", "#2E4E6A", "#ED7D31", "#FBE5D6", "#F8CBAD", "#F4B183",
                                  "#B25E25", "#763E18", "#A5A5A5", "#EDEDED", "#DBDBDB", "#C9C9C9",
                                  "#7C7C7C", "#525252", "#FFC000", "#FFF2CC", "#FFE699", "#FFD966",
                                  "#BF9000", "#806000", "#4472C4", "#DAE3F3", "#B4C7E7", "#8FAADC",
                                  "#335693", "#223962", "#70AD47", "#E2EFDA", "#C6DEB5", "#A9CE91",
                                  "#548235", "#385624", "#0563C1", "#CDE0F3", "#9BC1E6", "#69A1DA",
                                  "#044A91", "#023260", "#954F72", "#EADCE3", "#D5B9C7", "#BF95AA",
                                  "#703B56", "#4A2839"), .Dim = c(6L, 12L),
                                .Dimnames = list(NULL,
                                                 c("lt1", "dk1", "lt2", "dk2", "accent1", "accent2", "accent3",
                                                   "accent4", "accent5", "accent6", "hlink", "folHlink")))));
})
