module KNN where

import Data.List

{--
A KNN model simply consists of keeping track of the
Xs and the Ys. Where Xs is the data which leads to
some outcome or classification Y. When we want to
make a prediction on this data set, we pass values
which have been observed, X, and then compute the
euclidian distance between the passed in Xs and all
of the Xs in our model. We then sort the outcomes Y
by their distance to the input, and return the K
nearest to our passed in input.
--}

data KNNModel = KNNModel
    { xs :: [[Float]] -- Input data as a row entry
    , y  :: [Int]     -- Labels/Categories for the corresponding row entry
    }


kNNFit :: [[Float]] -> [Int] -> KNNModel
kNNFit xInput yInput = KNNModel
    { xs = xInput
    , y  = yInput
    }

euclidDistance :: [Float] -> [Float] -> Float
euclidDistance x y = sqrt $ sum $ map (\x -> x*x) (zipWith (-) x y)

-- Trained Model -> Input data -> (Distance, Label/Value)
computeDistances :: KNNModel -> [Float] -> [(Float, Int)]
computeDistances model input = zip [euclidDistance input x | x <- (xs model)] (y model)

-- Trained Model -> k-value -> Input data -> Output prediction
kNNPredict :: KNNModel -> Int -> [Float] -> Int 
kNNPredict model k input = snd $ maximum $ map (\x -> (length x, head x)) $ group kNearest
    where 
    --Takes the k nearest from sorted, removes the distances and just gives us the y values
    kNearest = map (\(_,x) -> x) (take k sorted)

    --Computes distances from input and sorts them nearest to farthest
    sorted = sortBy (\(a,_) (b,_) -> compare a b) (computeDistances model input)

-- Given a model, k value, input data, and expected result, what percentage is correct?
kNNTest :: KNNModel -> Int -> [[Float]] -> [Int] -> Float
kNNTest model k xs ys = correctPredictions / total 
    where correctPredictions = (fromIntegral (foldl (\x y -> if y then x+1 else x+0) 0 predictions))
          predictions = zipWith (==) ys [kNNPredict model k x | x <- xs]
          total = fromIntegral $ length predictions