import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/location_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationSearchDialog extends StatefulWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({Key? key, required this.mapController}) : super(key: key);

  @override
  State<LocationSearchDialog> createState() => _LocationSearchDialogState();
}

class _LocationSearchDialogState extends State<LocationSearchDialog> {
  final TextEditingController controller = TextEditingController();
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 80),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(width: 1170, child: TypeAheadField(
          controller: controller,
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                  hintText: getTranslated('search_location', context),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          style: BorderStyle.none, width: 0)),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Theme.of(context).disabledColor),
                  filled: true,
                  fillColor: Theme.of(context).cardColor),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeLarge)
            );
          },
          suggestionsCallback: (pattern) async {
            return await Provider.of<LocationProvider>(context, listen: false).searchLocation(context, pattern);
          },
          itemBuilder: (context,  suggestion) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Row(children: [
                const Icon(Icons.location_on),
                Expanded(
                  child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color, fontSize: Dimensions.fontSizeLarge,
                  )),
                ),
              ]),
            );
          },
          onSelected: (Prediction suggestion) {
            Provider.of<LocationProvider>(context, listen: false).setLocation(suggestion.placeId, suggestion.description, widget.mapController);
            Navigator.pop(context);
          },
        )),
      ),
    );
  }
}