import Text.Pandoc.JSON
import Text.Pandoc.Walk

grepLinks :: Pandoc -> Pandoc
grepLinks = (Pandoc nullMeta) . (query extractURL)

extractURL :: Inline -> [Block]
extractURL (Link _ _ (u,_)) = [Plain [Str u]]
extractURL (Image _ _ (u,_)) = [Plain [Str u]]
extractURL _ = []

main :: IO ()
main = toJSONFilter grepLinks
