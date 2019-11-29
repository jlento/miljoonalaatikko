# CSC's current (2019-02-18) documentation in markdown

The  converted   documents  are  in   folders  [software-pages],
[environment-guide], and  [taito-guide]. The  rest of  this file
describes how they were converted from the LifeRay warped HTML.

## Disclaimers

- If  the result in  some  places  looks ugly,  that's  possibly
  because of  hard spaces  or other "formatting",  inserted into
  HTML.
- Filenames may be funky, they are taken from the urls
- There is lot's of garbage in the output that needs cleaning

## How the conversion was made

### Requirements


- The  urls of  the individual software  pages and  user guides'
  chapters  are collected  with [links.js]  script, which  needs
  [nodejs] and [npm].
- The  HTML  is  fetched  and  cleaned  with  [content.js],  and
  converted to markdown using [Pandoc]
- Justification  is done  with [Emacs],  [markdown-mode.el], and
  [fmt.el], wrapped in [fmt.sh]
  
### Scrape the URLs

List of  sofware page urls  in file [software.txt]  is collected
using

    node utils/links.js '.portlet-body table a' 'https://research.csc.fi/software-details' > software-pages/software.txt

    node utils/links.js '.portlet-body table a' 'https://research.csc.fi/software-details?p_p_id=101_INSTANCE_bwNv9EAV4eYX&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-2&p_p_col_count=1&_101_INSTANCE_bwNv9EAV4eYX_delta=100&_101_INSTANCE_bwNv9EAV4eYX_keywords=&_101_INSTANCE_bwNv9EAV4eYX_advancedSearch=false&_101_INSTANCE_bwNv9EAV4eYX_andOperator=true&p_r_p_564233524_resetCur=false&_101_INSTANCE_bwNv9EAV4eYX_cur=2' >> software-pages/software.txt

List  of chapter  urls in  files [environment.txt]  is collected
using

    node utils/links.js '.no-print a' 'https://research.csc.fi/csc-guide' | sed -n 's|/csc-guide-[^a][^p][^p].*|https://research.csc.fi&|p' > environment-guide/environment.txt

List of chapter urls in files [taito.txt] is collected using

    node utils/links.js '.no-print a' 'https://research.csc.fi/taito-user-guide' | sed -e 's|^/||' -e 's|.*|https://research.csc.fi/&|' > taito-guide/taito.txt

List of chapter urls in files [pouta.txt] is collected using

    node utils/links.js '.journal-content-article a' 'https://research.csc.fi/pouta-user-guide' | sort -u | sed -E 's|(^/)(.*)|https://research.csc.fi/\2|' > pouta-guide/pouta.txt

List of page urls in [linux-101.txt] is collected using

    node $utils/links.js '.no-print a' 'https://research.csc.fi/csc-guide-linux-basics-for-csc' | sed -n '/#/!s|/csc-guide-[^a][^p][^p].*|https://research.csc.fi&|p' > linux-101/linux-101.txt

List of page urls in [fgci.txt] is collected using

    node $utils/links.js '.journal-content-article a' 'https://research.csc.fi/fgci-user-guide' | sed -n -e 's|/fgci-[^a][^p][^p].*|https://research.csc.fi&|p' | sed 's|#.*||' | sort -u >fgci/fgci.txt


### Convert the pages

Software pages:

    bash utils/convert.sh software-pages/software.txt

CSC environment guide:

    bash utils/convert.sh environment-guide/environment.txt

Taito guide:

    bash utils/convert.sh taito-guide/taito.txt

Linux 101:

    bash utils/convert.sh taito-guide/taito.txt
    for f in linux-101/*.md; do echo $f; sed -i -r 's|^#+ <a.*/a>|# |' $f; done

FGCI:

    bash utils/convert.sh taito-guide/taito.txt
    for f in linux-fgci/*.md; do echo $f; sed -i -r 's|^#+ <a.*/a>|# |' $f; done
    

[software-pages]: software-pages
[environment-guide]: environment-guide
[taito-guide]: taito-guide
[links.js]: utils/links.js
[nodejs]: https://nodejs.org
[npm]: https://www.npmjs.com
[content.js]: content.js
[Emacs]: https://www.gnu.org/software/emacs
[markdown-mode.el]: https://jblevins.org/projects/markdown-mode
[fmt.el]: fmt.el
[fmt.sh]: fmt.sh
[software.txt]: software-pages/urls.txt
[environment.txt]: environment-guide/environment.txt
[taito.txt]: taito-guide/taito.txt
[pouta.txt]: pouta-guide/pouta.txt
[Pandoc]: https://pandoc.org

