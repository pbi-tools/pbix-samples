# pbix-samples

*Collection of publicly available PBIX files extracted into PbixProj format*

Various [Power BI Ideas](https://ideas.powerbi.com/forums/265200-power-bi-ideas) address the lack of being able to properly source-control Power BI projects or to get any visibilty of the internal structure of a PBIX file for QA purposes or automation scenarious, etc. Most recently, [this idea was added](https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/36978934-built-in-git-support-in-powerbi-desktop), which also happens to reference various other related ideas:

- https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/17523715-report-version-control
- https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/7861287-dataset-report-version-control
- https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/34315045-seamless-version-control-of-queries-data-model-st
- https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/9677517-source-control
- https://ideas.powerbi.com/forums/265200-power-bi-ideas/suggestions/9080776-using-git-or-some-other-sccs-to-store-m-queries-n

This repository contains a number of PBIX files that have been converted into a source control compatible format, to serve as a proof-of-concept, a format proposal, as well as a discussion place for the community and, ideally, the Power BI team.

The format proposed here is loss-less, i.e. would be sufficient to re-assemble a fully functioning PBIX file from sources only.

## /powerbi-desktop-samples

Mirrors the repository containing PBIX files used in monthly release announcements at https://github.com/Microsoft/powerbi-desktop-samples, and instead of the binary PBIX files contains their extracted contents.