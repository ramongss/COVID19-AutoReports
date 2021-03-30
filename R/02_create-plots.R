library(extrafont)

data_br <- read.csv(file = here::here("data", "treated-data.csv"))

roundUp <- function(x, to = 10) {
  to*(x%/%to + as.logical(x%%to))
}

ma_plot_deaths <- function(data, colour = "red") {
  ggplot(data = data, aes(x = as.Date(date))) +
    geom_col(
      aes(y = new_deaths),
      size = 1,
      fill = colour,
      alpha = .3
    ) +
    geom_line(aes(y = ma_deaths), group = 1, size = 3.5, color = "white") +
    geom_line(
      aes(y = ma_deaths,
          lty = "Moving average of the daily deaths in the last seven days in Brazil"),
      group = 1, size = 1.2, color = colour
    ) +
    geom_point(
      data = data[which(data$new_deaths == max(data$new_deaths)),],
      aes(y = new_deaths), size = 4, color = colour
    ) +
    geom_text(
      aes(
        y = new_deaths,
        label = ifelse(new_deaths == max(new_deaths), scales::number(max(new_deaths)), "")
      ), vjust = -1, family = "Times New Roman", size = 5
    ) +
    scale_x_date(
      date_breaks = '1 month',
      date_labels = '%b %Y'
    ) +
    theme(
      text = element_text(size = 25, family = 'Times New Roman'),
      axis.title = element_blank(),
      axis.ticks.y = element_blank(),
      panel.background = element_rect(fill = "white"),
      axis.line.x.bottom = element_line(size = 1),
      panel.grid.major.y = element_line(size = 0.5, color = 'gray95'),
      panel.grid.minor.y = element_line(size = 0.5, color = 'gray95'),
      panel.grid.major.x = element_blank(),
      axis.text.y = element_text(vjust = -0.3, color = "gray50"),
      axis.text.x = element_text(angle = 45, hjust = 1),
      axis.ticks.x = element_line(size = 1),
      axis.ticks.length = unit(.25, "cm"),
      legend.text = element_text(size = 18, color = "gray50"),
      legend.key = element_blank(),
      legend.title = element_blank(),
      legend.position = 'top',
      legend.justification = 'left',
      plot.caption = element_text(size = 12, color = "gray50"),
    ) +
    scale_y_continuous(
      expand = c(0,0),
      breaks = c(0, seq(500, roundUp(max(data$new_deaths), 500), 1000)),
      labels = scales::number_format()
    ) +
    annotate(geom = 'text', x = as.Date(min(data$date)),
             y = roundUp(max(data$new_deaths), 500),
             hjust = .35, vjust = -.30,
             label = 'daily deaths', color = 'gray50',
             family = 'Times New Roman', size = 7) +
    labs(
      caption = paste0(
        'Source: Brasil.IO COVID-19 Dataset - Last Updated\n',
        format(Sys.time(), '%d %b %Y, %H:%M'),
        '(UTC) | Twitter: @ramongss'
      )
    )+
    coord_cartesian(
      ylim = c(0, roundUp(max(data$new_deaths), 500)+500)
    )
}

ma_plot_conf <- function(data, colour = "blue") {
  ggplot(data = data, aes(x = as.Date(date))) +
    geom_col(
      aes(y = new_confirmed),
      size = 1,
      fill = colour,
      alpha = .3
    ) +
    geom_line(aes(y = ma_conf), group = 1, size = 3.5, color = "white") +
    geom_line(
      aes(y = ma_conf,
          lty = "Moving average of the daily confirmed in the last seven days in Brazil"),
      group = 1, size = 1.2, color = colour
    ) +
    geom_point(
      data = data[which(data$new_confirmed == max(data$new_confirmed)),],
      aes(y = new_confirmed), size = 4, color = colour
    ) +
    geom_text(
      aes(
        y = new_confirmed,
        label = ifelse(new_confirmed == max(new_confirmed), scales::number(max(new_confirmed)), "")
      ), vjust = -1, family = "Times New Roman", size = 5
    ) +
    scale_x_date(
      date_breaks = '1 month',
      date_labels = '%b %Y'
    ) +
    theme(
      text = element_text(size = 25, family = 'Times New Roman'),
      axis.title = element_blank(),
      axis.ticks.y = element_blank(),
      panel.background = element_rect(fill = "white"),
      axis.line.x.bottom = element_line(size = 1),
      panel.grid.major.y = element_line(size = 0.5, color = 'gray95'),
      panel.grid.minor.y = element_line(size = 0.5, color = 'gray95'),
      panel.grid.major.x = element_blank(),
      axis.text.y = element_text(vjust = -0.3, color = "gray50"),
      axis.text.x = element_text(angle = 45, hjust = 1),
      axis.ticks.x = element_line(size = 1),
      axis.ticks.length = unit(.25, "cm"),
      legend.text = element_text(size = 18, color = "gray50"),
      legend.key = element_blank(),
      legend.title = element_blank(),
      legend.position = 'top',
      legend.justification = 'left',
      plot.caption = element_text(size = 12, color = "gray50"),
    ) +
    scale_y_continuous(
      expand = c(0,0),
      breaks = seq(0, roundUp(max(data$new_confirmed), 100000), 25000),
      labels = scales::number_format()
    ) +
    annotate(geom = 'text', x = as.Date(min(data$date)),
             y = roundUp(max(data$new_confirmed), 100000),
             hjust = .15, vjust = -.30,
             label = 'daily confirmed cases', color = 'gray50',
             family = 'Times New Roman', size = 7) +
    labs(
      caption = paste0(
        'Source: Brasil.IO COVID-19 Dataset - Last Updated\n',
        format(Sys.time(), '%d %b %Y, %H:%M'),
        '(UTC) | Twitter: @ramongss'
      )
    )+
    coord_cartesian(
      ylim = c(0, roundUp(max(data$new_confirmed), 500)+20000)
    )
}
