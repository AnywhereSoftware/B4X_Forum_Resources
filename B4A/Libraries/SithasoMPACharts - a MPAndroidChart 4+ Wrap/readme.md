### SithasoMPACharts - a MPAndroidChart 4+ Wrap by Mashiane
### 10/12/2026
[B4X Forum - B4A - Libraries](https://www.b4x.com/android/forum/threads/172242/)

Hi coders…  
  
[Github Repo](https://github.com/Mashiane/SithasoMPACharts)  
  
I needed a charting framework for the [B4XDaisyUIKit](https://www.b4x.com/android/forum/threads/b4x-b4a-b4xdaisyuikit-native-components-inspired-by-daisyui-tailwind.170352/) that can also be used with other android UI components easily. I found a beautiful charting framework here in the forum, [MPAndroidCharts](https://www.b4x.com/android/forum/threads/mpandroidcharts-various-type-of-graphs-charts-latest-library-v1-22-in-post-1.58017/) done by [USER=47104]@Johan Schoeman[/USER] back in 2015.  
  
Fortunately the latest version of MPAndroidCharts is now standing at 4.0.1 which is currently maintained. With the help of AI, I have wrapped it up for use in B4A. We have more than 90 chart examples in the APK, the images below demonstrate charts we have also managed to create using Themes.  
  
As it takes time and resources to create and maintain these libraries, this is [DonationWare](https://paypal.me/anelembanga).  
  
![](https://www.b4x.com/android/forum/attachments/173997)  
  
![](https://www.b4x.com/android/forum/attachments/173998)  
  
The demo application contains a browsable gallery of 127 interactive examples divided into categories:  
  
**[SIZE=5]1. Core Chart Types (11)[/SIZE]**  
  
- **Line Chart**: Smooth cubic bezier curves, customizable stroke widths, point circles, and data values.  
- **Area Chart**: Smooth lines with soft vertical gradients and translucent fill alpha.  
- **Column Chart**: Vertical bars with corner radius rounding, bar gradient fills, and shadow effects.  
- **Horizontal Bar Chart**: Left-to-right bars with inverted category and value axes.  
- **Pie & Donut Chart**: Pie slices with entry labels, donut center text with two-tone typography, and slice spacing.  
- **Scatter Chart**: Multi-series coordinate plotting with customizable shapes (Circle, Triangle, Square, Cross, Chevron).  
- **Bubble Chart**: 3-variable plotting $(x, y, \text{size})$ with auto-normalized bubble diameters.  
- **Radar Chart**: Multi-axis spider/web comparison plots with polygon filling.  
- **Candlestick Chart**: Financial trading charts with configurable bullish/bearish candle colors and wick widths.  
- **Combo Chart**: Combined line and column data sets rendered on shared or dual independent axes.  
- **Polar Area / Nightingale Rose**: Radial area charts with angle-based value encoding.  
  
[HEADING=2]2. Multi-Series & Grouping (9)[/HEADING]  
- **Grouped Columns**: Side-by-side category bars with configurable group spacing and bar width.  
- **Stacked Columns & Bars**: Multi-value segment bars with section corner rounding and segment labels.  
- **Dual Y-Axes**: Left and Right independent value scales (e.g. Temperature on Left, Pressure on Right).  
- **Pill-Shaped Stacked/Grouped Bars**: Capsule-style bars with `PillShape` property.  
- **Multiple Series**: Multiple comparative lines/areas on a single plot with automatic or custom palettes.  
- **Value Alignment**: Control over in-bar and point label positioning.  
- **Scatter Coordinates**: Multi-series coordinate plotting with explicit X/Y pairs.  
- **Series Colors**: Custom palette assignment per dataset.  
- **Empty State**: Graceful handling of zero-data scenarios.  
  
**[SIZE=5]3. Axis, Grid & Formatting Controls (10)[/SIZE]**  
  
- **Dashed Grid Lines**: Native dashed Cartesian and HorizontalBar grid lines (`DrawDashedGrid`, `GridDashLength`, `GridDashSpace`).  
- **Axis Granularity**: Precise minimum step intervals on numerical axes (`AxisGranularity`).  
- **Zero Filtering (`IgnoreZero`)**: Automatic omission of zero values while preserving category positions.  
- **Limit Lines**: Threshold indicators with custom colors, line widths, and dashed styles.  
- **Rotated Labels**: Angled or vertical X-axis labels (e.g. -90° rotation) to eliminate overlap on high-density categories.  
- **Prefixes & Suffixes**: Currency formatting (`$`), percentage signs (`%`), unit tags (`k`, `M`), and thousand separators.  
- **Stepped Lines**: Staircase transition plots for benchmark rates and discrete intervals.  
- **Axis Limits & Auto-Scaling**: Manual or automatic min/max with `AxisMinimum` / `AxisMaximum`.  
- **Straight Lines**: Linear interpolation mode for sharp transitions.  
- **No Grid / Pan-Zoom Off**: Clean presentation modes with interaction disabled.  
  
[HEADING=2]4. Data Labels & Values (4)[/HEADING]  
- **Data Values**: Numeric labels on every data point.  
- **Currency Prefix**: Automatic `$` / currency symbol formatting.  
- **Percent Donut**: Pie/donut slices rendered as percentages of total.  
- **Slice Leaders**: Leader lines for outside slice labels on pie/donut charts.  
  
[HEADING=2]5. Animation & Interactivity (6)[/HEADING]  
- **Animate X and Y**: Simultaneous dual-axis entrance animation.  
- **Animate XY Columns**: Column-specific entrance animation.  
- **Realtime Streaming**: `AddRealtimeEntry` / `AddRealtimeValue` for live data feeds.  
- **Easing Bounce**: 28 easing functions (Bounce, Elastic, Back, Expo, etc.).  
- **High Density Line**: Optimized rendering for large datasets.  
- **24-Hour Timeline**: Time-axis formatting for hourly data.  
  
[HEADING=2]6. Visual Styling (10)[/HEADING]  
- **Title and Subtitle**: Header text with alignment, color, size, and weight controls.  
- **Rotated Labels**: Angled axis labels for dense categories.  
- **Scatter Shapes**: Circle, Triangle, Square, Cross, X, Chevron point shapes.  
- **Sine Wave Bars**: Curved bar styling for oscillating data.  
- **Positive/Negative Column**: Automatic color split for positive vs negative values.  
- **Negative Horizontal Bar**: Inverted horizontal bars for negative datasets.  
- **Bar Borders**: Per-bar stroke outlines with custom width/color.  
- **Bar Corner Styles**: Round all corners or tip-only (`BarCornerStyle`).  
- **Custom Palette**: User-defined color lists cycled across series.  
- **Legend Customization**: Position (top/bottom/left/right), form (circle/square/line), orientation, draw-inside mode, and visibility (auto/show/hide).  
  
[HEADING=2]7. Themes & Palettes (6 Built-in Themes × 7 Variants = 42)[/HEADING]  
Each theme provides 7 contextual examples (Revenue, Orders, Budget, Sessions, Spend, ACME Corp, Team Profile/Growth/Deal Size):  
  
- **Nightfall** (Modern Teal / Cyan palette on clean background)  
- **Nightfall Dark** (Sleek dark mode theme)  
- **Cyberpunk** (High-contrast neon cyan, magenta, and electric yellow)  
- **Material Design** (Google Material vibrant palette)  
- **Pastel** (Harmonious muted tones for reports)  
- **Liberty** (Professional enterprise palette)  
  
[HEADING=2]8. Radial / Gauge Charts (11)[/HEADING]  
- **Radial Single**: Single progress ring.  
- **Radial Center Image**: Ring with centered bitmap/image.  
- **Radial Bar Labels**: Name + value stacked at ring start (Apex barLabels style).  
- **Radial Gauge Label**: Gauge with labeled tick marks.  
- **Radial Single Dashed**: Dashed segment ring.  
- **Radial Dashed Gauge**: Dashed gauge with tick marks.  
- **Radial**: Standard multi-ring gauge.  
- **Radial Semi**: Half-circle (180°) gauge.  
- **Radial Dashed**: Multi-ring dashed gauge.  
- **Radial Gradient**: Rings with sweep gradient (color → lighter tint).  
- **Radial Gauge**: Full gauge with min/max/value labels.  
  
[HEADING=2]9. Advanced & Composite (14)[/HEADING]  
- **Multi-line Straight**: Multiple lines with linear interpolation.  
- **Multi-series Area**: Stacked/overlaid area charts.  
- **Multi-series Gradient**: Gradient fills per dataset.  
- **Slice Leaders**: Outside labels with leader lines on pie/donut.  
- **Bar Borders**: Outlined bars/columns with custom width/color.  
- **Combo Layers**: Line + column + scatter on shared axes.  
- **Axis Chrome**: Full axis styling (lines, labels, titles, zero line).  
- **Candle Style**: Bullish/bearish colors, wick width, body fill.  
- **Radar Web**: Spider web polygon with configurable rings/axes.  
- **High Density Line**: Optimized rendering for large datasets.  
- **24-Hour Timeline**: Time-axis formatting for hourly data.  
- **Realtime Streaming**: `AddRealtimeEntry` / `AddRealtimeValue` for live feeds.  
- **Easing Bounce**: 28 easing functions (Bounce, Elastic, Back, Expo, etc.).  
- **Empty State**: Graceful handling of zero-data scenarios.  
  
#SharingTheGoodness  
  
PS: See Gifs below of actual running code - all properties are setable including the animation speeds.