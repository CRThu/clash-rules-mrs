# clash-rules-mrs

基于 [Loyalsoldier/clash-rules](https://github.com/Loyalsoldier/clash-rules) 纯文本规则集，自动化每日同步并编译为 **Mihomo (Clash.Meta)** 原生二进制规则集（`.mrs` 格式）。

## 特性

- **模块化对称架构**：源码保存在 `raw/<source>/`，产物结构化输出至 `out/<source>/`，具备多规则源隔离能力。
- **极小体积**：二进制编译与压缩，规则集体积缩减 60% ~ 80%（如 `reject` 从 5.2MB 缩减至 1.7MB）。
- **极速解析**：客户端启动与重载秒级完成，大幅降低移动端与路由设备的内存占用。
- **每日同步**：GitHub Actions 于北京时间每日 **07:00（UTC 23:00）** 自动拉取上游最新规则并编译发布到 `release` 分支与 GitHub Releases。

---

## 规则集列表 (Loyalsoldier 源)

| 规则名称 | 规则类型 | 格式 | 订阅路径 | 说明 |
| :--- | :--- | :--- | :--- | :--- |
| `reject` | `domain` | `mrs` | `loyalsoldier/reject.mrs` | 广告及隐私追踪域名 |
| `icloud` | `domain` | `mrs` | `loyalsoldier/icloud.mrs` | 苹果 iCloud 域名 |
| `apple` | `domain` | `mrs` | `loyalsoldier/apple.mrs` | 苹果常用服务域名 |
| `google` | `domain` | `mrs` | `loyalsoldier/google.mrs` | 谷歌服务域名 |
| `proxy` | `domain` | `mrs` | `loyalsoldier/proxy.mrs` | 常用代理域名 |
| `direct` | `domain` | `mrs` | `loyalsoldier/direct.mrs` | 常用直连域名 |
| `private` | `domain` | `mrs` | `loyalsoldier/private.mrs` | 私有网络域名 |
| `gfw` | `domain` | `mrs` | `loyalsoldier/gfw.mrs` | GFW 域名列表 |
| `greatfire` | `domain` | `mrs` | `loyalsoldier/greatfire.mrs` | GreatFire 域名列表 |
| `tld-not-cn` | `domain` | `mrs` | `loyalsoldier/tld-not-cn.mrs` | 非 .cn 顶级域名 |
| `telegramcidr` | `ipcidr` | `mrs` | `loyalsoldier/telegramcidr.mrs` | Telegram IP 段 |
| `cncidr` | `ipcidr` | `mrs` | `loyalsoldier/cncidr.mrs` | 中国大陆 IPv4/IPv6 段 |
| `lancidr` | `ipcidr` | `mrs` | `loyalsoldier/lancidr.mrs` | 局域网 IP 段 |

---

## 客户端配置示例 (ClashMi / Mihomo)

将 `CRThu/clash-rules-mrs` 替换为你的 GitHub 仓库地址：

```yaml
rule-providers:
  reject:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/reject.mrs"
    path: ./ruleset/loyalsoldier/reject.mrs
    interval: 86400

  icloud:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/icloud.mrs"
    path: ./ruleset/loyalsoldier/icloud.mrs
    interval: 86400

  apple:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/apple.mrs"
    path: ./ruleset/loyalsoldier/apple.mrs
    interval: 86400

  google:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/google.mrs"
    path: ./ruleset/loyalsoldier/google.mrs
    interval: 86400

  proxy:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/proxy.mrs"
    path: ./ruleset/loyalsoldier/proxy.mrs
    interval: 86400

  direct:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/direct.mrs"
    path: ./ruleset/loyalsoldier/direct.mrs
    interval: 86400

  private:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/private.mrs"
    path: ./ruleset/loyalsoldier/private.mrs
    interval: 86400

  gfw:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/gfw.mrs"
    path: ./ruleset/loyalsoldier/gfw.mrs
    interval: 86400

  greatfire:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/greatfire.mrs"
    path: ./ruleset/loyalsoldier/greatfire.mrs
    interval: 86400

  tld-not-cn:
    type: http
    behavior: domain
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/tld-not-cn.mrs"
    path: ./ruleset/loyalsoldier/tld-not-cn.mrs
    interval: 86400

  telegramcidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/telegramcidr.mrs"
    path: ./ruleset/loyalsoldier/telegramcidr.mrs
    interval: 86400

  cncidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/cncidr.mrs"
    path: ./ruleset/loyalsoldier/cncidr.mrs
    interval: 86400

  lancidr:
    type: http
    behavior: ipcidr
    format: mrs
    url: "https://cdn.jsdelivr.net/gh/CRThu/clash-rules-mrs@release/loyalsoldier/lancidr.mrs"
    path: ./ruleset/loyalsoldier/lancidr.mrs
    interval: 86400
```
