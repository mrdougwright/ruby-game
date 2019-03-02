require "gosu"
require "ostruct"

class GameWindow < Gosu::Window
  STATE = {
    scroll_clouds: 0,
    scroll_x: 0
  }

  def initialize(*args)
    super

    @images = {
      background: Gosu::Image.new("images/background.png"),
      foreground1: Gosu::Image.new("images/foreground1.png", {tileable: true}),
      foreground2: Gosu::Image.new("images/foreground2.png", {tileable: true})
    }

    @state = OpenStruct.new(STATE)
  end

  def button_down(button)
    case button
    when Gosu::KbEscape then close

    end
  end

  def update
    @state.scroll_clouds += 1.0
    @state.scroll_x += 1.5

    if @state.scroll_clouds > @images[:foreground1].width
      @state.scroll_clouds = 0
    end

    if @state.scroll_x > @images[:foreground1].width
      @state.scroll_x = 0
    end
  end

  def draw
    @images[:background].draw(0, 0, 0)
    @images[:foreground1].draw(-@state.scroll_clouds, 0, 0)
    @images[:foreground1].draw(-@state.scroll_clouds + @images[:foreground1].width, 0, 0)

    @images[:foreground2].draw(-@state.scroll_x, 0, 0)
    @images[:foreground2].draw(-@state.scroll_x + @images[:foreground2].width, 0, 0)
  end
end

window = GameWindow.new(500, 500, false)
window.show