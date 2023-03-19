module Main (main) where
import System.Environment (getArgs)
import System.IO (openFile, IOMode (ReadMode), hGetContents, hFlush, stdout)

run :: String -> IO ()
run code = do
    putStrLn $ "Executing " ++ code
    return ()

replLoop :: String -> IO ()
replLoop [] = return ()
replLoop line = run line >> runPrompt

runPrompt :: IO ()
runPrompt = putStr ">> " >> hFlush stdout >> getLine >>= replLoop

runFile :: FilePath -> IO ()
runFile file = openFile file ReadMode >>= hGetContents >>= run

main :: IO ()
main = do
    r <- getArgs
    case r of
        [] -> runPrompt
        [file] -> runFile file
        _ -> putStrLn "Usage: hlox [script]"