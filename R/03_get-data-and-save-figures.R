Sys.setenv("LANGUAGE" = "En")
Sys.setlocale("LC_ALL", "English")

# download data
source(here::here("R", "01_download-data.R"))

# load plot functions
source(here::here("R", "02_create-plots.R"))

# save figs
ma_plot_conf(data_br, colour = "#2171B5") %>%
  ggsave(
    filename = here::here("figures","confirmed.png"),
    device = "png",
    dpi = 300,
    units = "in",
    width = 12,
    height = 6.75
  )

ma_plot_deaths(data_br, colour = "#9B0000") %>%
  ggsave(
    filename = here::here("figures","deaths.png"),
    device = "png",
    dpi = 300,
    units = "in",
    width = 12,
    height = 6.75
  )
