function result = stitch(im1, im2)
    [f1, f2, matches, scores] = keypoint_matching(im1, im2);
    bt = RANSAC(f1, f2, matches, scores);
    M = [bt(1), bt(2); bt(3), bt(4)];
    T = [bt(5); bt(6)];
end