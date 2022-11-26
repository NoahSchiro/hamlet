module Matrix where

-- Matrix data type
data Matrix a = Matrix 
    { numRow   :: Int
    , numCol   :: Int
    , contents :: [[a]]
    } deriving (Eq,Read)

-- Easy way to convert to a 2d matrix
toMatrix :: (Num a) => [[a]] -> Matrix a
toMatrix input = Matrix 
    { numRow   = length input
    , numCol   = length (head input)
    , contents = input
    }

-- Make it print the matrix in the way that I want it to
instance (Num a, Show a) => Show (Matrix a) where
    show mat = unlines $ map (unwords . map show) (contents mat)


instance (Num a) => Num (Matrix a) where
    
    -- Matrix addition
    m1 + m2 = toMatrix (zipWith (zipWith (+)) a b)
        where a = contents m1
              b = contents m2

    -- Matrix subtraction
    m1 - m2 = toMatrix (zipWith (zipWith (-)) a b)
        where a = contents m1
              b = contents m2

    -- TODO
    m1 * m2        = undefined
    abs m1         = undefined
    signum m1      = undefined
    fromInteger m1 = undefined
