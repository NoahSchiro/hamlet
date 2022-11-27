module Tools where

-- Percent you want as training and dataset as input
testTrainSplit :: Float -> [[Float]] -> ([[Float]], [[Float]])
testTrainSplit percent dataset = (take count dataset, drop count dataset)
    where count = floor (percent * (fromIntegral $ length dataset))