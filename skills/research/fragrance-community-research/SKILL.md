---
name: fragrance-community-research
description: "Use when researching perfumes/fragrances from non-influencer sources: community databases, forums, Reddit, retailer note pyramids, clone/inspiration claims, performance, sillage, longevity, and concise source-cited summaries."
---

# Fragrance Community Research

Use this when the user asks what a fragrance smells like, what it clones/is inspired by, how it performs, or how communities describe it — especially when they ask to avoid influencers, affiliate pages, TikTok/Instagram/YouTube, or promotional reviews.

## Source priority

1. **Community databases first**: Fragrantica, Parfumo, Basenotes, WikiParfum, similar public databases.
   - Prefer pages with ratings, user reviews, note pyramids, “reminds me of” / similar-fragrance sections, performance votes, and discussion comments.
2. **Retailers/brand pages only for specs**: notes, concentration, size, launch/brand copy, stated inspiration. Treat performance and praise on sales pages as promotional unless corroborated.
3. **Forums/Reddit as secondary evidence**: use comments only when they are ordinary user discussion and not obviously affiliate/promotional. Quote sparingly and indicate disagreement when present.
4. **Avoid or down-rank**: TikTok/Instagram/YouTube influencers, “top clone” affiliate blogs, coupon pages, SEO listicles, and pages that exist mainly to monetize purchases.

## Workflow

1. Search exact product name plus `Fragrantica`, `Parfumo`, `Basenotes`, `Reddit`, and likely clone target terms.
2. Open community database pages first. If browser rendering is blocked, try read-only CLI retrieval with a normal user agent and compression before giving up.
3. Extract:
   - note pyramid and concentration;
   - stated inspiration / clone target;
   - rating count and score;
   - performance votes if available;
   - representative review-language for smell, projection/sillage, longevity, and common criticisms.
4. Separate **database/retailer facts** from **user impressions**.
5. Synthesize disagreement instead of forcing a single verdict: e.g. “most say long lasting, but several report 3–5h.”
6. Return in the user’s requested language and format. For Polish summaries, keep it concise, with bullets, source URLs, confidence, and limitations.

## Tool patterns

- Search engines often block direct scraping. Brave Search HTML can still reveal key URLs; use it for discovery when Google/DDG block.
- Fragrantica may show Cloudflare in browser but still be retrievable with:
  `curl -L --compressed -A 'Mozilla/5.0 research' '<url>' -o /tmp/page.html`
- Fragrantica pages may HTML-escape review metadata such as `&quot;longevity&quot;`; unescape before regex/parsing.
- When extracting performance votes from Fragrantica review markup, filter out `longevity=0, sillage=0` as “no vote”; map longevity 1–5 and sillage 1–4 using the page’s own legend when present.
- Reddit may return 403 even via JSON/old Reddit/Jina. If blocked, do not cite inaccessible Reddit content; mention it as an access limitation only if relevant.

## Output checklist

- Smell profile in plain language.
- Clone / inspiration target and confidence.
- Projection/sillage and longevity with range + disagreement.
- Source URLs grouped by type.
- Confidence/limitations section.

## References

- `references/bujairami-hectic.md` — worked example: researching an obscure clone fragrance using Fragrantica, Brave discovery, blocked Parfumo/Reddit, and performance-vote extraction.
