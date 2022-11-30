module NaiveBayes where

{--
Bayes' Theorem states

P[A|B] = (P[A] * P[B|A]) / (P[B])

However, this can be applied to an arbitrary number of "attributes" and an aribitrary number
of "classes" such that for any given class, we can look at the probability that some given set of
features indicates that it is a member of that class. 

For example, if I told you that our possible classes is the set of all fruits, and then the
features of a given object is that it is red, it is round, it is about 7cm in diameter. A naive
bayesian classifier looks at each of these features independently and asks the question "what is the 
probability that this fruit has [FEATURE], if we assume it is a [CLASS]?" Is then gets the product of
these probabilities, normalizes and takes the arg max to see whichever class has the highest probability.

The naivety comes from the assumption that these variables are independent of each other, which in the real
world is often not the case. Never the less, Naive Bayesian Classifiers succeed in being speed and accuracy.
--}

{--
Probability table stores in each row

[C, P(C), P(X_0|C), P(X_1|C), ..., P(X_n|C)]

where C is class and X is the features. Note that Haskell does not let us store multiple types in one list.
We want users to be able to pass in a general "class" type, whatever that might be. To get arround this, we 
will omit the "C" all together and just say that row number i is class i. We then need a seperate look up 
table where the index of an entry indicates it's class number. Example:

classTable = ["Good", "Bad", "So-so"]

probTable = [
    [P("Good") , P(X_0|"Good") , ..., P(X_n|"Good")]
    [P("Bad")  , P(X_0|"Bad")  , ..., P(X_n|"Bad")]
    [P("So-so"), P(X_0|"So-so"), ..., P(X_n|"So-so")]
]
--}
data BayesModel = BayesModel
    { numClasses  :: Int
    , numFeatures :: Int
    , classTable  :: [a]
    , probTable   :: [[Float]]
    }

