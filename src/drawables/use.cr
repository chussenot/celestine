struct Celestine::Use < Celestine::Drawable
  include Celestine::Modules::Position
  include Celestine::Modules::Body
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Transform
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Mask

  property target_id : String = ""

  def initialize()
  end

  def initialize(@target_id : Sting)
  end

  def initialize(target : Celestine::Drawable)
    if target.id
      @target_id = target.id.as(String)
    else
      raise "No id on use"
    end
  end
  
  
  def draw
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << position_options unless position_options.empty?
    options << body_options unless body_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?

    inner_tags = String::Builder.new
    inner_tags << animate_tags
    inner_tags << animate_motion_tags
    tags = inner_tags.to_s
    if tags.empty?
      %Q[<use href="##{target_id}" #{options.join(" ")} />]
    else
      %Q[<use href="##{target_id}" #{options.join(" ")}>#{tags}</use>]
    end
  end
end