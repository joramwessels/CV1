function matches = keypoint_matching(im1, im2)
    [F1, D1] = vl_sift(im1);
    [F2, D2] = vl_sift(im2);
    matches  = vl_ubcmatch(D1, D2);
end