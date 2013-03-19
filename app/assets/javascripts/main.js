/*
 * jQuery File Upload Plugin JS Example 6.5.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {

    function update(coords)
    {
      $('#picture_crop_x').val(coords.x)
      $('#picture_crop_y').val(coords.y)
      $('#picture_crop_w').val(coords.w)
      $('#picture_crop_h').val(coords.h)
    };

    $('#cropbox').Jcrop({
      boxWidth: 1000,
      boxHeight: 1000,
      onSelect: update,
      onChange: update
    });


    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      autoUpload: true,
      uploadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
          console.log(file);
            var row = $('<li class="span3">' +
                '<div class="thumbnail">' +
                  '<div class="preview" style="text-align: center;"></div>' +
                  '<div class="progress progress-success progress-striped active">' +
                    '<div class="bar" style="width:0%;"></div>' +
                  '</div>' +
                '</div>');
            rows = rows.add(row);
        });
        return rows;
    },

    completed: function(e, data) {
      console.log(data.result[0].url);
//      $('a[href^="' + data.result[0].url + '"]').slimbox();
    },
    downloadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
            var row = $('<li class="span3" id="picture_' + file.picture_id + '">' +
                (file.error ? '<div class="name"></div>' +
                    '<div class="size"></div><div class="error" ></div>' :
                      '<div class="thumbnail">' +
                        '<a class="image-thumbnail" title="" href="' + file.url + '" rel="shadowbox[gallery]">' +
                          '<img src="" alt="">') +
                        '</a>' +
                        '<div class="caption">' +
                          '<p style="text-align: center;">' +
                            '<td><span class="best_in_place btn-show" id="best_in_place_picture_description" data-url="" data-object="picture" data-attribute="description" data-type="input"><td class="description"></td> </span></td>' +
                                '<i class="icon-edit "></i>' +
                            '</a>' +
                            '<a class="btn-delete" data-confirm="Are you sure?" data-method="delete"  href="" data-remote=true>' +
                                '<i class="icon-trash"></i>' +
                            '</a>' +
                          '</p>' +
                        '</div>' +
                      '</div>');


            if (file.error) {
                row.find('.name').text(file.name);
                row.find('.error').text(
                    locale.fileupload.errors[file.error] || file.error
                );
            } else {
                if (file.thumbnail_url) {
                    row.find('img').prop('src', file.thumbnail_url);
                }
                row.find('.btn-delete')
                    .attr('href', '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id);
                row.find('.btn-show')
                    .attr('data-url', '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id);
                row.find('.description')
                    .attr('td', file.description);
                row.find('.image-thumbnail')
                    .attr('class', "picture_"+ file.picture_id);
            }
            rows = rows.add(row);

        });
        return rows;
    }

  });
});
