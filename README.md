# clash-rules-mrs

基于 [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules) 纯文本规则集，自动化每日同步并编译为 **Mihomo (Clash.Meta)** 原生二进制规则集（`.mrs` 格式）。

## 特性

- **极小体积**：二进制编译与压缩，规则集体积缩减 60% ~ 80%（如 `reject` 从 5.2MB 缩减至 1.7MB）。
- **极速解析**：客户端启动与重载秒级完成，大幅降低移动端与路由设备的内存占用。
- **每日同步**：GitHub Actions 于北京时间每日 **07:00（UTC 23:00）** 自动拉取上游最新规则并编译发布到 `release` 分支与 GitHub Releases。
- **对称架构**：源文件保存在 `raw/<source>/`，产物结构化输出至 `out/<source>/`。

---

## ⚡ 极简推荐配置（绕过大陆 / 白名单模式）

这是绝大多数用户推荐采用的**黄金极简配置**（仅需 4 个核心规则 + 1 条兜底，兼具极致性能与 100% 零误分流）：

```yaml
rule-providers:
  private:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/private.mrs"
    path: ./ruleset/private.mrs
    interval: 86400

  lancidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/lancidr.mrs"
    path: ./ruleset/lancidr.mrs
    interval: 86400

  direct:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/direct.mrs"
    path: ./ruleset/direct.mrs
    interval: 86400

  cncidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/cncidr.mrs"
    path: ./ruleset/cncidr.mrs
    interval: 86400

rules:
  # 1. 局域网与私有网络直连（纯 IP 规则加 no-resolve 避免多余解析）
  - RULE-SET,private,DIRECT
  - RULE-SET,lancidr,DIRECT,no-resolve

  # 2. 国内流量直连（先匹配 6 万+ 常用国内域名；未命中的由最新大陆 CIDR + 本地 GeoIP 双重兜底）
  - RULE-SET,direct,DIRECT
  - RULE-SET,cncidr,DIRECT
  - GEOIP,CN,DIRECT

  # 3. 最终兜底：非大陆流量全走代理
  - MATCH,PROXY
```

---

## 完整规则集列表 (Loyalsoldier 源)

| 规则名称 | 规则类型 | 格式 | 订阅路径 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| `direct` | `domain` | `mrs` | `loyalsoldier/direct.mrs` | 常用直连域名 |
| `cncidr` | `ipcidr` | `mrs` | `loyalsoldier/cncidr.mrs` | 中国大陆 IPv4/IPv6 段 |
| `private` | `domain` | `mrs` | `loyalsoldier/private.mrs` | 私有网络域名 |
| `lancidr` | `ipcidr` | `mrs` | `loyalsoldier/lancidr.mrs` | 局域网 IP 段 |
| `gfw` | `domain` | `mrs` | `loyalsoldier/gfw.mrs` | GFW 域名列表 |
| `proxy` | `domain` | `mrs` | `loyalsoldier/proxy.mrs` | 常用代理域名 |
| `reject` | `domain` | `mrs` | `loyalsoldier/reject.mrs` | 广告及隐私追踪域名 |
| `apple` | `domain` | `mrs` | `loyalsoldier/apple.mrs` | 苹果常用服务域名 |
| `google` | `domain` | `mrs` | `loyalsoldier/google.mrs` | 谷歌服务域名 |
| `icloud` | `domain` | `mrs` | `loyalsoldier/icloud.mrs` | 苹果 iCloud 域名 |
| `tld-not-cn` | `domain` | `mrs` | `loyalsoldier/tld-not-cn.mrs` | 非 .cn 顶级域名 |
| `telegramcidr` | `ipcidr` | `mrs` | `loyalsoldier/telegramcidr.mrs` | Telegram IP 段 |
| `greatfire` | `domain` | `mrs` | `loyalsoldier/greatfire.mrs` | GreatFire 域名列表 |

---

## 全量 `rule-providers` 订阅模版（按需选用）

```yaml
rule-providers:
  reject:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/reject.mrs"
    path: ./ruleset/reject.mrs
    interval: 86400

  icloud:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/icloud.mrs"
    path: ./ruleset/icloud.mrs
    interval: 86400

  apple:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/apple.mrs"
    path: ./ruleset/apple.mrs
    interval: 86400

  google:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/google.mrs"
    path: ./ruleset/google.mrs
    interval: 86400

  proxy:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/proxy.mrs"
    path: ./ruleset/proxy.mrs
    interval: 86400

  direct:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/direct.mrs"
    path: ./ruleset/direct.mrs
    interval: 86400

  private:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/private.mrs"
    path: ./ruleset/private.mrs
    interval: 86400

  gfw:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/gfw.mrs"
    path: ./ruleset/gfw.mrs
    interval: 86400

  greatfire:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/greatfire.mrs"
    path: ./ruleset/greatfire.mrs
    interval: 86400

  tld-not-cn:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/tld-not-cn.mrs"
    path: ./ruleset/tld-not-cn.mrs
    interval: 86400

  telegramcidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/telegramcidr.mrs"
    path: ./ruleset/telegramcidr.mrs
    interval: 86400

  cncidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/cncidr.mrs"
    path: ./ruleset/cncidr.mrs
    interval: 86400

  lancidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/lancidr.mrs"
    path: ./ruleset/lancidr.mrs
    interval: 86400
```
