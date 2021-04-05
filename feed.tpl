<!DOCTYPE html>
<html lang="en">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1" />
  <title>{{ .Title }}</title>

  <meta name="theme-color" content="#000000" />
  <meta name="description" content="aggregated feed for {{ .Title }}" />

  <link rel="icon" href="https://seankhliao.com/favicon.ico" />
  <link rel="icon" href="https://seankhliao.com/static/icon.svg" type="image/svg+xml" sizes="any" />
  <link rel="apple-touch-icon" href="https://seankhliao.com/static/icon-192.png" />

  <style>
    * {
      box-sizing: border-box;
    }
    :root {
      background: #000;
      color: #eceff1;
      font: 18px "Inconsolata", monospace;
    }

    @font-face {
      font-family: "Inconsolata";
      font-style: normal;
      font-weight: 400;
      font-display: swap;
      src: local("Inconsolata"), local("Inconsolata-Regular"),
        url(https://seankhliao.com/static/inconsolata-var.woff2) format("woff2-variations"),
        url(https://seankhliao.com/static/inconsolata-400.woff2) format("woff2");
    }
    @font-face {
      font-family: "Inconsolata";
      font-style: normal;
      font-weight: 700;
      font-display: swap;
      src: local("Inconsolata Bold"), local("Inconsolata-Bold"),
        url(https://seankhliao.com/static/inconsolata-var.woff2) format("woff2-variations"),
        url(https://seankhliao.com/static/inconsolata-700.woff2) format("woff2");
    }
    @font-face {
      font-family: "Lora";
      font-style: normal;
      font-weight: 400;
      font-display: swap;
      src: local("Lora"), local("Lora-Regular"),
        url(https://seankhliao.com/static/lora-var.woff2) format("woff2-variations"),
        url(https://seankhliao.com/static/lora-400.woff2) format("woff2");
    }
    @font-face {
      font-family: "Lora";
      font-style: normal;
      font-weight: 700;
      font-display: swap;
      src: local("Lora Bold"), local("Lora-Bold"),
        url(https://seankhliao.com/static/lora-var.woff2) format("woff2-variations"),
        url(https://seankhliao.com/static/lora-700.woff2) format("woff2");
    }

    /* ===== layout general ===== */
    body {
      display: grid;
      grid: 3.5vh 3.5vh/ 1fr 9fr 9fr 1fr;
      gap: 0 1em;
      margin: 0;
      padding: 1vmin;

      /* ==override newtab page == */
      background: #000;
      color: #eceff1;
      font: 18px "Inconsolata", monospace;
    }

    body > * {
      grid-column: 2 / span 2;
    }

    /* ===== layout header ===== */
    h1 {
      font-size: 3vmin;
      grid-area: 1 / 3 / span 1 / span 1;
      margin: 0;
      place-self: end;
    }
    h2 {
      color: #999;
      margin: 0;
      font-size: 2.5vmin;
      grid-area: 2 / 3 / span 1 / span 1;
      place-self: start end;
      text-align: right;
    }

    hgroup {
      font: 700 2.5vmin "Lora", serif;
      grid-area: 1 / 2 / span 2 / span 1;
      margin: 0;
      place-self: end start;
    }
    hgroup a {
      display: grid;
      grid: repeat(2, 3vmin) / repeat(8, 4vmin);
      place-content: center center;
    }
    hgroup *:nth-child(n + 5) {
      grid-row: 2 / span 1;
    }
    /* ===== full bleed ===== */
    table,
    picture {
      grid-column: 1 / span 4;
      margin: 1em -1vmin;
    }

    /* ===== layout main ===== */
    h3,
    h4 {
      margin: 25vh 0 0.25em 0;
    }

    h3 {
      font-size: 2.441em;
    }
    h4 {
      font-size: 1.953em;
    }
    p {
      line-height: 1.5;
      margin: 0 0 1em 0;
    }

    /* ===== style ===== */
    a,
    a:visited {
      color: inherit;
      font-weight: 700;
      text-decoration: underline 1px #707070;
    }
    a:hover {
      color: #a06be0;
      transition: color 0.16s;
      text-decoration: underline 1px #a06be0;
    }

    h1 a,
    h1 a:hover,
    h1 a:visited,
    hgroup a,
    hgroup a:hover,
    hgroup a:visited {
      color: inherit;
      text-decoration: none;
    }

    em {
      color: #a06be0;
      background-color: unset;
      font-style: normal;
      font-weight: 700;
    }
    time {
      color: #999;
    }

    table {
      border-collapse: collapse;
      border-style: hidden;
      margin: 10vh 0;
    }
    th,
    td {
      padding: 0.4em;
      text-align: left;
    }
    th {
      font-weight: 700;
      border-bottom: 0.2em solid #999;
    }
    tr:nth-child(5n) td {
      border-bottom: 0.1em solid #999;
    }
    tbody tr:hover {
      background: #404040;
    }

    .content {
      overflow: hidden;
      max-width: 75ch;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    /* ===== gtm ===== */
    noscript iframe {
      height: 0;
      width: 0;
      display: none;
      visibility: hidden;
    }
  </style>

  <h1><a href="/"><em>feed</em>-agg</a></h1>
  <h2>aggregated feed for {{ .Title }}</h2>

  <hgroup>
    <a href="https://seankhliao.com/?utm_medium=sites&utm_source=feed-agg.seankhliao.com">
      <span>S</span><span>E</span><span>A</span><span>N</span> <em>K</em><em>.</em><em>H</em><em>.</em> <span>L</span
      ><span>I</span><span>A</span><span>O</span>
    </a>
  </hgroup>

  <table>
    <thead>
      <tr>
        <td><em>title</em></td>
        <td>source</td>
        <td>updated</td>
        <td>author</td>
        <td>link</td>
        <td>description</td>
      </tr>
    </thead>
    <tbody>
    {{- range $it := .Items }}
      <tr>
        <td>{{ $it.Title }}</td>
        <td>{{ $it.Source.Href }}</td>
        <td><time>{{ $it.Updated }}</time</td>
        <td>{{ $it.Author.Name }}</td>
        <td><a href="{{ $it.Link.Href }}">link</a></td>
        <td><p class="content">{{ $it.Description }}</p></td>
      </tr>
    {{- end }}
    </tbody>
  </table>
</html>
