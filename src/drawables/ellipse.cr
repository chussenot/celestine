struct Celestine::Ellipse < Celestine::Drawable 
  include Celestine::Modules::Transform
  include Celestine::Modules::CPosition
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Mask
  
  property radius_x : SIFNumber = 0
  property radius_y : SIFNumber = 0

  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?

    inner_tags = String::Builder.new
    inner_tags << animate_tags
    inner_tags << animate_motion_tags
    tags = inner_tags.to_s
    if tags.empty?
      %Q[<ellipse rx="#{radius_x}" ry="#{radius_y}" #{options.join(" ")} />]
    else
      %Q[<ellipse rx="#{radius_x}" ry="#{radius_y}" #{options.join(" ")}>#{tags}</ellipse>]
    end
  end

  module Attrs
    RADIUS_X = "rx"
    RADIUS_Y = "ry"
  end
end