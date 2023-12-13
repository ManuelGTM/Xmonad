calc x y z = x + x * (y/100) + z

list = [4,4,4,4,5,5]

listcom = [x | x <- [1..10]]

listcom' :: [Char] -> Int
listcom' x = sum [1 | _ <- x]

















































