struct Celestine::Group < Celestine::Drawable
  include Celestine::Modules::Transform
  include Celestine::Modules::StrokeFill
  include Celestine::Modules::Animate
  include Celestine::Modules::Animate::Motion
  include Celestine::Modules::Mask
  

  @objects = [] of Celestine::Drawable

  property? override_stroke_fill = false

  def draw
    s = String::Builder.new
    options = [] of String
    options << class_options unless class_options.empty?
    options << id_options unless id_options.empty?
    options << stroke_fill_options unless stroke_fill_options.empty?
    options << transform_options unless transform_options.empty?
    options << style_options unless style_options.empty?
    options << mask_options unless mask_options.empty?

    
    s << %Q[<g #{options.join(" ")}>]
    s << animate_tags
    s << animate_motion_tags



    @objects.each do |drawable|
      s << drawable.draw
    end
    s << %Q[</g>]

    s.to_s
  end
end