---
layout: page
title: Extensions
nav_order: 4
description: Extensions to the Basic ERGM
---

# Extensions to the Basic ERGM
{:.no_toc}

Now that we have a general understanding with ERGMs and some familiarity with using them in R, we turn to a conceptual discussion of extensions to ERGMs. The purpose of this discussion is to provide you with a preview of what the basic ERGM can do with two tweaks.

# Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

## Adding Constraints
Constraints are researcher-specified dyads where observed outcomes are not modelled as outcomes.
- These dyads are held at their observed values, tie or no tie (i.e. constant or treated as exogeneous)
- This removes the tie from being part of the outcome data (i.e. their rows are removed in the data)
- They still matter to local configuration counts/calculation of change statistics

### They can be used in a number of ways to account for the data generating process
{:.no_toc}
- In temporally-aggregated network, sometimes actors never existed at the same time
- For example, some states from the post-Cold War network never existed at the same time in the global system
- Constraints can also be used to get rid of "outliers" in the data
- For example, in a scientific lab collaboration network, the lab responsible for producing a widely-used reagent might have their ties fixed at the observed state

### More important for the current discussion, constraints can be used systematically to produce specific network types
{:.no_toc}

---

### Bipartite Networks
> Bipartite networks have two different types of nodes; ties can form across types but not within types.

- People attending meetings (e.g. policy actors and shared policy forums)
- Legislators signing bills

![Schematic representation of a bipartite network with 4 actors and 5 meetings.]({{ site.baseurl }}{% link assets/images/extension_bipartite.png %})

#### <span style="color:firebrick"> Constrained to no ties in the main diagonal blocks.</span>
{:.no_toc}

Bipartite networks are very common, and the `ergm` package has a lot of support for fitting these networks

---

### (Kind of) Directed Acyclic Graphs
> Directed acyclic graphs are directed graphs/networks that have no directed cycles

- In the social sciences, academic citation networks and judicial court citation networks are (kind of) directed acyclic graphs
- In academic publishing, working papers/preprints can lead to reciprocol citations
- In the US Supreme Court, cases decided within the same term can cite each other

![US Supreme Court citation network, 1937-2015.]({{ site.baseurl }}{% link assets/images/extension_acyclic.png %})

#### <span style="color:firebrick"> Constrained to no ties going back in order of publication unless they are within the same temporal period.</span>
{:.no_toc}

#### Resources:
{:.no_toc}
- the `cERGM` [package](https://github.com/schmid86/cERGM)


#### Reference:
{:.no_toc}
Schmid, CS et al. 2021. ["Generative dynamics of supreme court citations: Analysis with a new statistical network model."](https://arxiv.org/abs/2101.07197) _Political Analysis_.

---

## Specifying Relational Contexts
Relational contexts are conditions that systematically govern the probability of edge formation in a complex network. In the current discussion, they are researcher-specified.
- Extension of "conditional network effects" discussed in the introduction
- In different relational contexts, network effects are allowed to have different coefficients
- They can be understood as interaction terms
- They can be combined with constraints

---

### Multilayer Networks
> Networks that contain different types of relational contexts systematically organized into layers

- Flexible generalized framework that can account for many different types of network structures
- Network nodes are organized into _layers_, which represent different kinds of ties
- Temporal networks can be understood as multilayer networks where layers are temporal contexts

![Multilayer network representation of conflict in the Levant region, 1989-1995.]({{ site.baseurl }}{% link assets/images/extension_multilayer.png %})

#### <span style="color:firebrick"> Three relational contexts with no constraints.</span>
{:.no_toc}

- By allowing for different kinds of ties to exist in a network, we can model different things with what are otherwise the same network configurations
- For example, the pile-on effect in conflicts are not likely to be the same across different combinations of actors

#### Resources:
{:.no_toc}
- the `multilayer.ergm` [package](https://github.com/tedhchen/multilayer.ergm)
- the [MPNet](http://www.melnet.org.au/pnet) application

#### Reference:
{:.no_toc}
Chen, THY. 2021. ["Statistical inference for multilayer networks in political science".](https://doi.org/10.1017/psrm.2019.49) _Political Science Research and Methods_.

Wang, P et al. 2016 ["Social selection models for multilevel networks."](https://doi.org/10.1016/j.socnet.2014.12.003) _Social Networks_.

---

### Temporal Networks
> Temporal networks are networks where ties are time-period specific

- They are intuitive to understand as it, but in the context of network analysis, temporal networks can be understood as a special case of the multilayer networks 
- The time periods of the ties are the relational contexts

![Schematic illustration of temporal networks as multilayer networks.]({{ site.baseurl }}{% link assets/images/extension_temporal.png %})

#### <span style="color:firebrick"> As many relational contexts as time periods, constrained to have no ties across periods.</span>
{:.no_toc}

- Only ties within each temporal layer (i.e. period) can exist while the others cells are held to no ties
- This formulation helps with more advanced ERGMs, but for temporal networks where each time period is relatively simple, existing formulations and packages perform very well already


#### Resources:
{:.no_toc}
- the `xergm` [package](https://github.com/leifeld/xergm) (specifically `btergm`)

#### Reference:
{:.no_toc}
Leifeld, et al. 2018. ["Temporal exponential random graph models with btergm: Estimation and bootstrap confidence intervals".](https://www.jstatsoft.org/article/view/v083i06) _Journal of Statistical Software_.












