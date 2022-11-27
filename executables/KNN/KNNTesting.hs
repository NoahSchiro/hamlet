module Main where

import Data.List
import KNN
import Tools

filepath :: String
filepath = "./executables/KNN/diabetes.csv"

splitOn :: (Char -> Bool) -> String -> [String]
splitOn delim input =  case dropWhile delim input of
                            ""     -> []
                            input' -> w : splitOn delim input''
                                where (w, input'') = break delim input'

cleanCSV :: String -> [[Float]]
cleanCSV input = map (map (read)) noHeader                  -- Convert to float
    where noHeader     = tail splitOnComma                  -- Remove header info
          splitOnComma = map (splitOn (==',')) splitOnLine  -- Split each line by commas
          splitOnLine  = splitOn (=='\n') input             -- Split the whole string by new lines

main :: IO()
main = do
    
    -- Read in CSV file
    contents <- readFile filepath
    
    --Convert to 2D matrix
    let cleanContents = cleanCSV contents

    -- Create a test train split
    let (train, test) = testTrainSplit 0.8 cleanContents 

    -- Isolate the inputs and outputs
    let xTrain = map (take 8) train
    let yTrain = map (\x -> floor $ head $ reverse x) train :: [Int]
    let xTest  = map (take 8) test
    let yTest  = map (\x -> floor $ head $ reverse x) test :: [Int]

    -- Fit our model
    let model = kNNFit xTrain yTrain

    print (kNNPredict model 7 (xTest !! 0))