import Text.Pandoc.JSON
import Text.Pandoc.Walk
import Data.List

{- |
   Maintainer: Juha Lento <juha.lento@csc.fi>

Pandoc filter that cleans up HTML source from Liferay CMS website.
-}

main :: IO ()
main = toJSONFilter fromLifeRayPagesToSingleDoc

-- | Run three-step filter
-- Gets the class name of the div containing the actual page content
-- from the Pandoc metadata field "bodyclass" , and the base URL of
-- the site from the field "baseurl".
fromLifeRayPagesToSingleDoc :: Pandoc -> Pandoc
fromLifeRayPagesToSingleDoc (Pandoc meta bs) =
    Pandoc meta $
        (   walk  (inlineElements baseurl)
          . walk  blockElements
          . query (selectBlocks bodyclass)
        ) bs
    where
        bodyclass = case lookupMeta "bodyclass" meta of
            Just (MetaString s) -> s
            _                   -> "journal-content-article"
        baseurl   = case lookupMeta "baseurl" meta of
            Just (MetaString s) -> s
            _                   -> "https://research.csc.fi"

-- | Select blocks containing the book source
selectBlocks :: String -> Block -> [Block]
selectBlocks bodyclass (Div ("",[s],[]) bs)
    | s == bodyclass = bs
    | otherwise = []
selectBlocks _ _ = []

-- | Filter Block elements
blockElements :: Block -> Block
blockElements (Div (_,["no-print"],_) _) = Null
blockElements        (Para [Str "\160"]) = Null
blockElements        x@(Table _ _ _ _ _) = navigationTableToNull x
blockElements           x@(Header _ _ _) = cleanAnchorInHeader x
blockElements                          x = x

-- | Filter Inline elements
inlineElements :: String -> Inline -> Inline
inlineElements baseurl (Link attr value (url,title)) =
    Link attr value ((toAbsURL baseurl url),title)
inlineElements                        _  x = x


-- Helper functions

-- | Guess which tables are navigation tables and nullify them
navigationTableToNull :: Block -> Block
navigationTableToNull x
    | or $ query isNOP x = Null
    | otherwise = x
    where isNOP     (Link _ [Str "Next",Space,Str "chapter"] _) = [True]
          isNOP (Link _ [Str "Previous",Space,Str "chapter"] _) = [True]
          isNOP                                             _ = [False]

-- | Ugly work-around to a bug
cleanAnchorInHeader :: Block -> Block
cleanAnchorInHeader (Header l ha ((Span sa []):ins)) =
    Div ("",[],[]) [Plain [Span sa []], Header l ha ins]
cleanAnchorInHeader x = x

-- | Make relative URLs absolute
toAbsURL :: String -> String -> String
toAbsURL baseurl str
    | "data:" `isPrefixOf` str = str
    | "://"   `isInfixOf`  str = str
    | "/"     `isPrefixOf` str = baseurl ++ str
    | otherwise                = baseurl ++ '/':str
    where

