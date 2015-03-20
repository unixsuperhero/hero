module H
  extend self

  def note_tag
    n = Note.first
    [n, n.tags.first]
  end
end
